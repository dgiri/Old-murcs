# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include InheritedResources::DSL

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  
  before_filter :require_user, :set_current_user, :set_current_project_id
  
  def create_history
    if params[:target]
      case params[:target]
        when 'backlog'          
          new_state = "moved to backlog"
          old_state = "from #{@story.current_state}"
        when 'icebox'
          new_state = "moved to icebox"
          old_state = "from #{@story.current_state}"
        when 'indev'
          new_state = "started"
          old_state = "from #{@story.current_state}"
        else
          new_state = params[:target]
        end
    elsif controller_name == "stories" && action_name == "update"
      new_state = "edited"
    elsif controller_name == "comments" && action_name == "create"
      new_state = "added comment in"
    elsif controller_name == "tasks" && action_name == "create"
      new_state = "added a task in"
    elsif controller_name == "tasks" && action_name == "destroy"
      new_state = "deleted a task from"
    elsif controller_name == "tasks" && action_name == "update_task_status"
      new_state = "completed a task in"
    end
    if params[:target] != @story.current_state
      History.create!(:story_id => @story.id, :user_id => current_user, :new_state => new_state, :old_state => old_state, :action_time => Time.now) 
    end
  end
  
  protected
    def set_current_user
      Authorization.current_user = current_user
    end
    
    def set_current_project_id
      logger.info "controller name: #{self.controller_name}"
      current_user.current_project_id = case self.controller_name
      when 'projects'
        params[:id]
      else
        params[:project_id]
      end
    end

end

