Feature: Manage members 
  In order to manage members
  As an Admin
  I want to create and manage members & their roles 

  Background: 
    Given I am signed up with "somename/password"
    And I login as "somename/password"
    And the user "somename" has the following projects:
    | name     | 
    | project1 | 
    | project2 | 
    | project3 |


  Scenario: Adding new users to a particular project with valid data
    Given I am on the project list page
    When I follow "Members" to add member for "project1"
    Then I am on the invite member page for "project1"
    When I fill in "Email" with "abc@xyz.com"
    And I select "Member" from "Role"
    And I press "Add member"
    Then I should see "Membership was created successfully"
  
  Scenario: Adding new users to a particular project with invalid data
    Given I am on the project list page
    When I follow "Members" to add member for "project1"
    Then I am on the invite member page for "project1"
    When I fill in "Email" with ""
    And I select "Member" from "Role"
    And I press "Add member"
    Then I should see "Recipient email can't be blank"
    




  
