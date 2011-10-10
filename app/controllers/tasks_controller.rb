class TasksController < ApplicationController
  inherit_resources
  nested_belongs_to :project, :story
  
  before_filter :find_project
  before_filter :find_story
  after_filter :create_history, :only => [:create, :update_task_status, :destroy]
  
  respond_to :html, :xml
  respond_to :js, :only => [:create, :edit, :update, :destroy]
  
  def update
    @task = Task.find(params[:id])
  
    respond_to do |format|
      if @task.update_attributes(params[:task])
        flash[:notice] = 'Task was successfully updated.'
        format.html { redirect_to(@task) }
        format.js {
          render :update do |page|
            page["#Story-Task-List_#{@story.id}"].html(render(:partial => "tasks/task_list", :locals => {:story => @task.story, :project => @project }))
            page <<  "$('#Task-Updation-Option_#{@task.id}').hide();"
            page['#Task-Details_#{@task.id}'].html('<%= escape_javascript(<%= t.description %>)')
            page <<  "$('#task_item_#{@task.id}').effect('highlight', {}, 10000);"             
          end         
        }        
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update_task_status
    @task = Task.find(params[:task_id])
    @task.status ? @task.update_attribute(:status, false) : @task.update_attribute(:status, true)
    
    respond_to do |format|
      format.html { }
      format.js {
        render :update do |page|
          page["#Story-Task-List_#{@story.id}"].html(render(:partial => "task_list", :locals => {:story => @task.story, :project => @project}))
          page <<  "$('#task_item_#{@task.id}').effect('highlight', {}, 10000);" 
        end       
      }
    end
  end

  private
    def find_project
      @project = Project.find(params[:project_id])
    end
    
    def find_story
      @story = Story.find(params[:story_id])
    end  
    

  protected
    def create_resource(object)
      object.user = current_user
      object.save
    end
  
end
