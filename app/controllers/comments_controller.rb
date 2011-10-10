class CommentsController < ApplicationController
  after_filter :create_history, :only => [:create]
  
  def create
    @project = Project.find(params[:project_id])
    @story = Story.find(params[:story_id])
    @comment = @story.comments.build(params[:comment].merge({:user_id => current_user.id}))      
    
    respond_to do |format|
      if @comment.save
        Notifier.deliver_commnet_message_notification(@story, @comment, @project)   
        format.html {
          flash[:notice] = 'Comment was successfully created.'
          redirect_to(edit_project_story_path(:id => @story, :project_id => @project))
        }
        format.js {
          render :update do |page|
            page["#Comment-List_#{@story.id}"].html(render(:partial => "comments/comments_list", :locals => {:story => @story, :project => @project}))
            page <<  "$('#comment_Item_#{@comment.id}').effect('highlight', {}, 10000);"
            page << "$('#new_comment').resetForm();"  
          end
        }
      else
        format.js {
          render :update do |page|
            page['#dialog-form'].dialog('open');
            page['#new_comment_errors'].show();
            page['#new_comment_errors'].html("#{@comment.errors.full_messages}");
          end          
        }        
      end
    end
  end
end
