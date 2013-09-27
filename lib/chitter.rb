require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require './helpers/user_helper'

env = ENV["RACK_ENV"] || "development"
DataMapper.setup(:default, "postgres://localhost:5432/chitter_#{env}")

require_relative '../lib/user'

DataMapper.finalize
DataMapper.auto_upgrade!

class Chitter < Sinatra::Base

helpers UserHelper
set :views,File.join(File.dirname(__FILE__), '..', 'views')
enable :sessions
  use Rack::Flash

  get '/' do
    erb :index
  end

  get '/users/new' do
  	erb :'users/new'
  end

  	post '/users' do
  		user =User.new(:email => params[:email], 
              :password => params[:password],
              :password_confirmation => params[:password_confirmation])
	    user.save

	    session[:user_id] = user.id

	    redirect to('/users/welcome')
  	end
  	
 	get '/users/welcome' do
		@user =User.all
	erb :'users/welcome'
  	end
  # start the server if ruby file executed directly
  #run! if app_file == $0
end
