Feature: Manage homepage
  In order to Register/Login in Murcs Loot
  As a user
  I want to see Register/Login link at the home page
  
  Scenario: Checking home page links before login
    Given I am not logged in user 
    When I go to the homepage 
    Then I should be on the login page
    When I follow "Signup"
    Then I should be on the signup page
    
  Scenario: Checking home page links after login
    Given I am a logged in user
    And I am on the homepage
    When I follow "All Projects"
    Then I am on the project list page

