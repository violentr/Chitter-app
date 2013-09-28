require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require './helpers/user_helper'
require './lib/link'
require './lib/tag'

env = ENV["RACK_ENV"] || "development"
DataMapper.setup(:default, "postgres://localhost:5432/chitter_#{env}")

require_relative '../lib/user'

DataMapper.finalize
DataMapper.auto_upgrade!

# class Chitter < Sinatra::Base

helpers UserHelper

set :views,File.join(File.dirname(__FILE__), '..', 'views')
enable :sessions
set :session_secret, 'Encryption key provided!'

use Rack::Flash

  get '/' do
    @links =Link.all
    erb :index
  end

  get '/users/new' do
    @user =User.new
  	erb :'users/new'
  end

  	post '/users' do
  		@user =User.new(:email => params[:email], 
              :password => params[:password],
              :password_confirmation => params[:password_confirmation])
	    if @user.save
	    session[:user_id] = @user.id
	    redirect to('/')
      else
        flash.now[:errors] = @user.errors.full_messages
        erb :'users/new'
      end
  	end

    post '/sessions' do
      email =params[:email]
      #nick =params[:nick]
      password =params[:password]
      user =User.authenticate(email,password)
      if user
        session[:user_id]=user.id
        redirect to('/')
      else
        flash[:errors]="The email or password you have entered is not correct"
        erb :'sessions/new'
      end
    end

    post '/links' do
      web_prefix = 'http://'
      url = web_prefix + params['url']
      title =params['title']
      tags = params['tags'].split(" ").map{|tag| Tag.new(:text => tag)}
      #puts tags
      Link.create(:url => url, :title => title, :tags => tags)
      redirect('/')

      erb :'users/links'
    end
    get '/users/links' do
    
      erb :'users/links'
    end

    get '/sessions/new' do
      #'Here is a Log in  session' 
      erb :'sessions/new'
    end

    get '/logout' do
      flash[:notice] = "Goodbye"
      session.clear
      redirect to('/')
    end
    
    # get '/users/layout'do
    #   @email =params['email']

    #   erb :'users/layout'
    # end

    # get '/users' do
    #   "Sorry your password doesn't match"
    # end
  	
 	  get '/users/welcome' do
  		@user =User.all
  	  erb :'users/welcome'
    end

  # helpers do
  #   def current_user    
  #     @current_user ||= User.get(session[:user_id]) if session[:user_id]
  #   end
  # end

  # start the server if ruby file executed directly
  #run! if app_file == $0

