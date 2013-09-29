require 'data_mapper'
require 'dm-validations'
require 'bcrypt'

class User

include DataMapper::Resource
	property :id, Serial
	property :email, String
	property :password, Text
	property :password_confirmation, Text 
	property :password_digest, Text


	 validates_confirmation_of :password, :message => "The passwords you typed did not match"
	 # password == password_confirmation
	
	def password=(password)
    	@password = password
	    self.password_digest = BCrypt::Password.create(password)

	end
	
	def self.authenticate(email,password)
		user =first(:email =>email)
		if user && BCrypt::Password.new(user.password_digest) ==password
			user
		else
			nil
		end
	end
end