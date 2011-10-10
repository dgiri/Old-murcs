require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  context "project" do
    setup do
      login 
      setup_roles
    end
    context "on GET to :new" do
      setup do
        get :new
      end
      should_render_template :new
    end

    context "on POST to :create" do
      context "create project with valid credential" do
        setup do
          post :create, :project => { :name => "Someprojectname" }
        end        
       # should_assign_to :project
        should_change("Number of projects", :by => 1) { Project.count }
        should_redirect_to("Project list page") { projects_path }
      end
      context "create with invalid data" do
        setup do  
          post :create, :project => { :name => "" }
        end 
        should_render_template :new
      end
    end  
  end
end
