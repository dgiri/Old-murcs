module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the homepage/       
      root_path

    when /the signup page/
      "/signup/"

    when /the login page/
      login_path 

    when /the add project page/
      new_project_path 
 
    when /the add story page for "(.+)"/
      project = Project.find_by_name($1)
      project_stories_path(project)
      

    when /the create new story page for "(.+)"/  
      project = Project.find_by_name($1)
      new_project_story_path(project)
 
    when /the story list page for "(.+)"/  
      project = Project.find_by_name($1)
      project_stories_path(project) 

    when /the project show page for "(.+)"/
      project = Project.find_by_name($1)
      project_stories_path(project)

    when /the edit story page for "(.+)" under "(.+)"/   
      story = Story.find_by_title($1) 
      project = Project.find_by_name($2)
      edit_project_story_path(project, story) 
 
    when /the project list page/
      projects_path

    when /the members index page/
      members_path
		
		when /the invite member page for "(.+)"/
			project = Project.find_by_name($1)
			project_memberships_path(project)
			
		when /story index page/
			project_stories_path
			  	
         
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
      "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
