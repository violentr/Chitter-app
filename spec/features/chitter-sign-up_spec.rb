
require 'spec_helper'
Capybara.app =Sinatra::Application
# Capybara.app = Chitter

# feature "User sign up for Chitter" do
# 	scenario "When user on the page" do
# 		visit('/')
# 		#page.save_and_open_page
# 	expect(page).to have_content('Hello Chitter')
# 	end
# 	scenario "when user being logged out" do
# 		lambda{sign_up}.should change(User, :count).by(1)
# 	expect(page).to have_content('Welcome den@example.com')
# 	expect(User.first.email).to have_content('den@example.com')
# 	end
feature do 	
	scenario "When password doesn't match" do
		lambda{sign_up('a@a.com','pass','wrong_pass')}.should change(User, :count).by(0)
		visit('/users/new')
		expect(current_path).to eq('/users')
		expect(page).to have_content("The passwords you typed did not match")
	end
	scenario "When no username" do
		sign_up('','','')
		expect(current_path).to eq('/users/new')
		expect(page).to have_content("No Username")
	end


	def sign_up(email="den@example.com",password='oranges!',password_confirmation='oranges!')
		visit '/users/new'
		#save_and_open_page
		fill_in :email, :with => email
		fill_in :password, :with => password
		fill_in :password_confirmation, :with => password_confirmation
		click_button "Login"
	end
	
	
end