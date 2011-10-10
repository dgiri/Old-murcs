Feature: Manage stories
  In order to manage stories
  As a logged in user
  I want to create and manage stories

  Background:

    Given I am signed up with "somename/password"
    And I login as "somename/password"
    And the user "somename" has the following projects:
    | id | name     |
    | 1  | project1 | 
    | 2  | project2 |
    | 3  | project3 | 
     
    Given the following stories exist:
    | title  | description  | story_type | current_state | project_id |
    | title1 | description1 | feature    | icebox        | 1          |
    | title2 | description2 | bug        | icebox        | 1          |
    | title3 | description3 | feature    | backlog       | 1          |
    | title4 | description4 | feature    | indev         | 1          |


  Scenario: Go to Create new story page from project details page
    And I am on the project list page 
    And I follow "project1" to add new stories to this project
    And I follow "Create new story" 
    Then I am on the create new story page for "project1"   
     	
  Scenario: Add Stories under a project with valid data
    And I am on the create new story page for "project1"
    When I fill in "Title" with "Story Title"
    And I fill in "Description" with "Story Description"
    And I select "Feature" from "Story type"
    And I select "2" from "Estimate"
    And I press "Add"
    Then I should see "Story was successfully created" 
  
  Scenario: Add a new story under a project with invalid data
    And I am on the create new story page for "project1"
    When I fill in "Title" with ""
    And I fill in "Description" with ""
    And I select "Feature" from "Story type"    
    And I press "Add"
    Then I should see error messages    
  
  Scenario: Show list of Stories under a project
    When I follow "project1" to add new stories to this project
    Then I should able to see the stories under "project1"
        
  Scenario: Move stories from Icebox to Backlog
    And I am on the story list page for "project1" 
    When I press "Confirm" to move story "title1" for "project1"  
    Then The story "title1" should move to "Backlog"
      
  Scenario: Move stories from Backlog to Icebox
    And I am on the story list page for "project1"
    When I press "Move to Icebox" to move story "Title3" for "project1"
    Then The story "Title3" should move to "Icebox"
         
  Scenario: Move stories from Backlog to Indev
    And I am on the story list page for "project1"
    When I press "Start" to move story "Title3" for "project1"
    Then The story "Title3" should move to "Indev"
     
  Scenario: Move stories from Indev to Backlog
    And I am on the story list page for "project1"
    When I press "Move to Backlog" to move story "Title4" for "project1"
    Then The story "Title4" should move to "Backlog"
      
  Scenario: Edit an existing story
    And I am on the story list page for "project1"
    When I follow "Edit Story" for "title1" under "project1"
    Then I am on the edit story page for "title1" under "project1"
    When I fill in "Title" with "story1"
    And I fill in "Description" with "Story Description"
    And I select "Feature" from "Story type"
    And I select "2" from "Estimate"
    And I press "Update"
    Then I should see "Story was successfully updated."
