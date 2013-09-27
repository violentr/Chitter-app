require 'spec_helper'

feature "User visti homepage" do
	scenario "When on the page" do
	expect(page).to have_content('hello Chitter')
end