Feature: Manage Project
  In order to manage project
  As a logged in user
  I want to create and manage project

  Background: 
    Given I am signed up with "somename/password"
    And I login as "somename/password"
    And the user "somename" has the following projects:
    | name     | 
    | project1 | 
    | project2 | 
    | project3 |
    
  Scenario: user should able to see his projects  
    When I follow "All Projects"
    Then I am on the project list page
    And I should see "project1"
    And I should see "project2"
    And I should see "project2"
    And I should not see "project5"
  
  Scenario: Add a new project with valid data
    And I am on the homepage
    When I follow "Add new project"
    And I am on the add project page
    And I fill in "Name" with "project4"
    And I press "Create"                                           
    Then I should see "Project was successfully created"  
    And I am on the project list page
    And I should see "project4"
       
  Scenario: Add a new project with invalid data
    And I am on the homepage
    When I follow "Add new project"
    And I am on the add project page
    And I fill in "Name" with ""
    And I press "Create"                                           
    Then I should see "Name can't be blank"  
  
  Scenario: View particular project details
    And I am on the project list page
    When I follow "project1"
    Then I am able to view the details for "project1" 
