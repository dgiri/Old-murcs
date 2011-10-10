When /^I follow "([^\"]*)" to add member for "([^\"]*)"$/ do |link, project_name|
  @project = Project.find_by_name(project_name)
  within(:css, "div#project_#{@project.id}") do
    click_link(link)
  end
end
