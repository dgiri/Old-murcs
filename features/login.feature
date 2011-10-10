Feature: Sign in
  In order to get access to protected sections of the site
  As a user
  I Should be able to sign in

  Scenario: User enters wrong password
    Given I am signed up with "email@example.com/password"
    When I am on the login page
    And I login as "email@example.com/wrongpassword"
    Then I should see error messages
    And I should be signed out

  Scenario: User signs in successfully
    Given I am signed up with "email@example.com/password"
    And I am on the login page
    And I login as "email@example.com/password"
    Then I should see "Successfully logged in"
    And I should be signed in

  Scenario: User logs out
    Given I am a logged in user
    And I am on the homepage
    When I follow "Logout"
    Then I should be signed out
