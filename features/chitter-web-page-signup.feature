Feature: SignUp to Chitter
 In order to use chitter to use chitter
 As a maker
 I want to login

 Scenario: I am on the chitter webpage
 Given I visit  Chitter home page
 Then I should see "Hello Chitter"

 Scenario:
 I am on the '/signup' page
 When I fill in "email" with password "12345"
 And I confirm with password "12345"
 And press Signup button
 Then I should see welcowme message

