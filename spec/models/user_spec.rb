require 'spec_helper'

describe User do
	it 'should not work without a email' do
		user = User.new(:email => "", :password => "pass", :password_confirmation => "pass")
		expect(user.save).to be_false
	end
end