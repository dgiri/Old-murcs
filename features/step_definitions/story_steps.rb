Given /^the following projects exist:$/ do |table|
  table.hashes.each do |hash|  
    Factory(:project, hash)  
  end
end

Given /^the following stories exist:$/ do |table|
  table.hashes.each do |hash|
    Factory(:story, hash)
  end
end

Given /^I want to move story "([^\"]*)" to "([^\"]*)"$/ do |title, target|
  @story = Story.find_by_title(title)
end

When /^I press "([^\"]*)" to move story "([^\"]*)" for "([^\"]*)"$/ do |button, story_title, project_name|
  project = Project.find_by_name(project_name)
  @story = project.stories.find_by_title(story_title)
  within(:css, "div#story_#{@story.id}") do
    click_button(button)
  end
end

Then /^The story "([^\"]*)" should move to "([^\"]*)"$/ do |story_title, current_state|
  @story = Story.find_by_title(story_title)
  assert_equal current_state.downcase, @story.current_state.downcase
end

When /^I follow "([^\"]*)" for "([^\"]*)" under "([^\"]*)"$/ do |link, story_title, project_name|
  @project = Project.find_by_name(project_name)
  @story = Story.find_by_title(story_title)
  within(:css, "div#story_#{@story.id}") do
    click_link(link)
  end
  visit edit_project_story_path(@project, @story)
end

Then /^I should able to see the stories under "([^\"]*)"$/ do |project|
  @story = Story.find_by_project_id(project)
end

When /^I follow "([^\"]*)" to add new stories to this project$/ do |project_name|
  project = Project.find_by_name(project_name)
  visit project_stories_path(project)
end