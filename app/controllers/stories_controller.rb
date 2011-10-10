class StoriesController < ApplicationController
  filter_access_to :all
  before_filter :find_project, :only => [:index, :change_state, :update_status, :new , :edit, :update]
  before_filter :find_story, :only  => [:change_state, :update_status, :edit, :update]
  before_filter :create_history, :only => [:change_state, :update, :update_status]

  inherit_resources
  belongs_to :project

  actions :all, :except => %w[index new edit]

  respond_to :html, :xml, :json
  
  def index
    @stories = @project.stories.find(:all, :order => "position ASC, created_at DESC")
    @story = @project.stories.find_by_id(params[:story_id]) if params[:story_id]
    @tracker_columns = TrackerColumn.get_opened_columns(current_user.id, @project.id)
    respond_to do |format|
      format.html { }
    end
  end
  
  def update_status
    unless params[:stories].blank?    
      story_ids = params[:stories].collect{|st| st.split("_")[1].to_i}
      stories = @project.stories.find(:all, :conditions => ["id in (?)", story_ids])
      Story.update_position(stories, story_ids)
    else
      
    end
    
    unless @story.current_state == params[:target]
      case params[:target]
        when 'backlog'
          @story.to_backlog!
        when 'icebox'
          @story.to_icebox!
        when 'indev'
          @story.owner = current_user
          @story.start!
        end
    end         
    respond_to do |format|
      format.html { flash[:alert] = t('flash.stories.change_state.alert') }
      format.js{render :text => "successful"}
    end     
  end
  
  def new
    @story = Story.new
    respond_to do |format|
      format.html { }
      format.js { 
        render :update do |page|
          page << "if($.inArray('icebox', ml.SELECTED_VIEW_COLUMNS) == -1){ml.selectView($('#icebox_link'), 'icebox');}"
          page["#new_story_div"].show(); 
          page['#new_story_div'].html(render(:partial => 'form'));
        end
      }
    end
  end
  
  def edit
     respond_to do |format| 
       format.js{
         render :update do |page|
           unless params[:option]
             page["#story-sort-Details_#{@story.id}"].hide();
             page["#story-Details_#{@story.id}"].show();
             page["#story-Details_#{@story.id}"].html(render(:partial => 'edit', :locals => {:story => @story, :project => @project}));
           else
              page["#story-Details_#{@story.id}"].hide();
              page["#story-sort-Details_#{@story.id}"].show();
           end
         end         
       }
     end 
  end
  
  create! do |success, failure|
    success.html { redirect_to(project_stories_path(@project)) }
    success.js {
      stories = @project.stories.find(:all, :order => "position ASC, created_at DESC") 
      render :update do |page|
          page << "$('#new_story').resetForm();"
          page["#new_story"].hide();          
          page["#test-sort1"].html(filtered_stories(stories, Story::STORY_STATES[:icebox]))
          page << "$('#story_#{@story.id}').effect('highlight', {}, 10000);"
      end
    }
    failure.js { 
      render :update do |page|
        page['#story_errors'].show();
        page['#story_errors'].html(error_messages_for :story);     
      end
    }    
  end
  
  update! do |success, failure|
    success.html {redirect_to(project_stories_path(@project))}
  end
  
  destroy! do |success, failure|
    success.html { redirect_to(project_stories_path(@project))}
  end

  def change_state
    do_change_state

  rescue AASM::InvalidTransition => e
    respond_to do |format|
      format.html { flash[:alert] = t('flash.stories.change_state.alert') }
      format.js { render :text => "success" }
    end
  ensure
    respond_to do |format|
      format.html { redirect_to(project_stories_path(@project)) }
      format.js{render :text => "error"}
    end
  end
  
  private
    def find_project
      @project = Project.find(params[:project_id])
    end
    
    def find_story
      @story = Story.find(params[:id])
    end  
      
    def do_change_state    
      case params[:target]
        when 'moved to backlog'
          @story.to_backlog!
        when 'moved to icebox'
          @story.to_icebox!
        when 'started'
          @story.owner = current_user
          @story.start!
        when 'finished'
          @story.finish!
        when 'delivered'
          @story.deliver!
        when 'accepted'
          @story.accept!
        when 'rejected'
          @story.reject!
        end
    end 
    
     
end
