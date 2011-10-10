class ProjectsController < ApplicationController
  filter_access_to :all
  
  inherit_resources
  actions :all, :except => [:tracker_column]
      
  create! do |success, failure|
    success.html { redirect_to projects_path }
    success.js {
      projects = current_user.projects 
      render :update do |page|
          page << "$('#new_Project_Form').resetForm();"
          page['#dashboard_Project_List'].html(render(:partial => "home/project_list", :locals => {:projects => projects})) 
          page << "$('#project_#{@project.id}').effect('highlight', {}, 5000);"
      end      
    }
    failure.html {
      render :action => "new"
    }
    failure.js {
      render :update do |page|
        page['#dialog-form'].dialog('open');
        page['#new_Project_Errors'].show();
        page['#new_Project_Errors'].html(error_messages_for :project);        
      end
    }
    
  end 
  
  def tracker_column
    case params[:did]
    when 'open'
      TrackerColumn.save_opened_column(current_user.id, params[:id], params[:tracker_column])
    when 'close'
      TrackerColumn.remove_closed_column(current_user.id, params[:id], params[:tracker_column])
    end
    render :layout => false, :text => 'ok'
  end
  
  protected
   def begin_of_association_chain
     current_user
   end
   
   def create_resource(object)
     object.save
     object.set_owner(current_user)
   end
end
