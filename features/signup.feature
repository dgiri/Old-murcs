Feature: User registration
  In order to get full access to protected sections of the site
  As a user
  I should be able to sign up

  Scenario: User signs up with invalid data
    Given I am on the signup page
    When I fill in "Username1" with "Somename"
    And I fill in "Email" with "somename@example.com"
    And I fill in "Password" with ""
    And I fill in "Password confirmation" with "password"
    And I press "Sign Up"
    Then I should see error messages

  Scenario: User signs up with valid data
    Given I am on the signup page
    When I fill in "Username" with "Somename"
    And I fill in "Email" with "email@person.com"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    And I press "Sign Up"
    Then I should see "Signed up successfully"

   
    
