Then /^I should see error messages$/ do
  assert page.has_xpath?('//*', :text => /error(s)? prohibited/m)
end

Then /^I should be signed out$/ do
  assert_nil UserSession.find
end

Then /^I should be signed in$/ do
  assert_not_nil UserSession.find
end

Given /^I am signed up with "(.*)\/(.*)"$/ do |login, password|
  user = Factory :user,
    :username              => login,
    :password              => password,
    :password_confirmation => password
end

When /^I login as "(.*)\/(.*)"$/ do |login, password|
  When %{I go to the login page}
  And %{I fill in "Email or Username" with "#{login}"}
  And %{I fill in "Password" with "#{password}"}
  And %{I press "Login"}
end

Given /^I am not logged in user$/ do
  user = nil
end

Given /^I am a logged in user$/ do
  user = Factory(:user)
  When %{I login as "#{user.email}/#{user.password}"}
end

Given /^I am a logged in user as an admin$/ do
  user = Factory(:user)
  When %{I login as "#{user.email}/#{user.password}"}
end

Given /^the user with username "([^\"]*)" and password "([^\"]*)" in the application$/ do |name, username, password|
  Factory.create(:user, :username => username, :name => name, :password => password)
end

Given /^the user "([^\"]*)" has the following projects:/ do |username, projects_table|
  user = User.find_by_username(username)
  projects_table.hashes.each do |project_hash|
     project = Factory.create(:project, project_hash)
     project.update_attribute(:user_id, user)
     project.set_owner(user)
   end
end