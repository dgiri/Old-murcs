require 'test_helper'       

class UserSessionsControllerTest < ActionController::TestCase  
  context "UserSession" do
    context "on GET to :new" do    
      should "user signin" do 
        get :new 
        assert_template 'new'
      end 
    end     

    context "on POST to :create" do
      context "with valid credentials" do
        setup do 
          @user = Factory(:user)
          post :create, :user_session => { :login => @user.email, :password => @user.password }
        end 

        should "create user session" do
          assert user_session = UserSession.find
          assert_equal @user, user_session.user
        end
        should_redirect_to("the home page") { root_url }
      end
      
      context "with invalid credentials" do
        setup do
          post :create, :user_session => { :email => "", :password => "" }
        end

        should_render_template :new 
      end      
    end  
    
    context "on DELETE to :destroy" do
      setup do
        UserSession.create(Factory(:user))
        delete :destroy
      end
      
      should "destroy user session" do
        assert_nil UserSession.find
      end
      should_redirect_to("the home page") { root_url }
    end
    
  end
end
