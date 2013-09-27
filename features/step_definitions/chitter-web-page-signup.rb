
Given(/^I visit  Chitter home page$/) do
	visit('/')
	page.to have_content('Hello Chitter')
end

When(/^I fill in "(.*?)" with password "(.*?)"$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

When(/^I confirm with password "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

When(/^press Signup button$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see welcowme message$/) do
  pending # express the regexp above with the code you wish you had
end
