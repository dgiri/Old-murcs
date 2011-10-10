require 'test_helper'
class MembershipsControllerTest < ActionController::TestCase
  context "Member" do 
    setup do
      login 
      setup_roles
    end  

    should_route :get, "projects/999999/memberships/new", :controller => :memberships, :action => :new, :project_id => 999999
    
    context "on POST to :create with valid data" do 
      setup do           
        @project = Factory(:project)
        @project.set_owner(current_user)
        post :create, :membership => { :recipient_email => 'foo@example.com', :role_id => Role::ADMIN.id }, :project_id => @project
      end
         
      should_redirect_to("Members list page") {project_memberships_path}
    end 
    
  end
  
end
