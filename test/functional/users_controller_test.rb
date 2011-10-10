require File.dirname(__FILE__) + '/../test_helper'

class UsersControllerTest < ActionController::TestCase   
  context "User" do
    context "on GET to :new" do        
      should "should get new user" do
        get :new
      end
    end 

    context "on POST to :create" do
      context "with valid data" do
        setup do
          post :create, :user => Factory.attributes_for(:user)
        end 
        should_change("User count", :by => 1) { User.count }  
        should_set_the_flash_to /Signed up successfully/i
        should_redirect_to("Home page") { root_url }
      end
      
      context "with invalid data" do
        setup do
          post :create
        end
        should_not_change("User count") { User.count }
        should_render_template :new
      end 
    end
  end
end
