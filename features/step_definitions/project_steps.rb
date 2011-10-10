Given /^I want to add stories to project "([^\"]*)"$/ do |name|
  project = Project.find_by_name(name)
  visit project_path(project)
end  

Then /^I am able to view the details for "([^\"]*)"$/ do |proj|
  project = Project.find_by_name(proj)  
  visit project_path(project)
end

Given /^I am a logged in as "([^\"]*)"$/ do |user|
  @user = User.find_by_username(user)  
end
