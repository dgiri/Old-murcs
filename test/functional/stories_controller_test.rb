require 'test_helper'

class StoriesControllerTest < ActionController::TestCase
  context "Story" do
    setup do
      login
      setup_roles
    end 
    
    context "on GET to :index" do
      setup do 
        @story = Factory(:story)
        @project = Factory(:project) 
        membership = Factory(:membership, :user => current_user, :project => @project, :role => Role.find_by_title('Admin'), :sender => current_user)
        get :index , :project_id => @project
      end 
      should_render_template :index
    end
      
    context "on GET to :new" do
      setup do 
        @project = Factory(:project)     
        membership = Factory(:membership, :user => current_user, :project => @project, :role => Role.find_by_title('Admin'), :sender => current_user) 
        get :new, :project_id => @project
      end
      
      should_render_template :new
    end
     
    context "on POST to :create" do
      setup do
        @project = Factory(:project)     
        membership = Factory(:membership, :user => current_user, :project => @project, :role => Role.find_by_title('Admin'), :sender => current_user) 
        post :create, :story => Factory.attributes_for(:story), :project_id => @project
      end                                                    
      
      should_assign_to :story
      should_change("Number of stories", :by => 1) { Story.count }
      should_redirect_to("Stories list page") { project_stories_path }
    end     
    
    context "on POST to :create with invalid data" do
      setup do
        @project = Factory(:project)      
        membership = Factory(:membership, :user => current_user, :project => @project, :role => Role.find_by_title('Admin'), :sender => current_user) 
        post :create, :project_id => @project 
      end 
      should_render_template :new
    end  
    
    context "on PUT to :update" do
      setup do
        @project = Factory(:project)   
        @story = Factory(:story)
        @project.stories = [@story]        
        membership = Factory(:membership, :user => current_user, :project => @project, :role => Role.find_by_title('Admin'), :sender => current_user) 
        @story.update_attributes(:title => "abc") 
        put :update, :id  => @story.id, :project_id => @project.id 
      end
      should_redirect_to("Stories list page") { project_stories_path } 
    end
    
    
    context 'Checking state for story in icebox' do
      setup do
        story = Factory(:story,:current_state => 'backlog')
        @story_id = story.id 
        @project = Factory(:project)            
        membership = Factory(:membership, :user => current_user, :project => @project, :role => Role.find_by_title('Admin'), :sender => current_user) 
        get :change_state, :id  => @story_id, :target => 'icebox', :project_id => @project
      end 
      should "return 'icebox' " do 
        story = Story.find(@story_id)
        assert_equal 'icebox', story.current_state       
      end
    end
        
    context 'Checking state for story in backlog' do
      setup do
        story = Factory(:story,:current_state => 'icebox')
        @story_id = story.id 
        @project = Factory(:project)            
        membership = Factory(:membership, :user => current_user, :project => @project, :role => Role.find_by_title('Admin'), :sender => current_user) 
        get :change_state, :id  => @story_id, :target => 'backlog', :project_id => @project 
      end 
      should "return 'backlog' " do   
        story = Story.find(@story_id)
        assert_equal 'backlog', story.current_state        
      end   
    end  
          
    context 'Checking state for story in indev' do
      setup do
        story = Factory(:story, :current_state => 'backlog')
        @story_id = story.id
        project = Factory(:project)                                              
        membership = Factory(:membership, :user => current_user, :project => project, :role => Role.find_by_title('Admin'), :sender => current_user)                            
        get :change_state, :id  => @story_id, :target => 'start', :project_id => project
      end 
      should "return 'indev' " do
        story = Story.find(@story_id)
        assert_equal 'indev', story.current_state        
      end

    end
    
  end 
end
