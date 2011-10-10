class HistoriesController < ApplicationController
  def index
    if params[:story_id]
      @histories = History.find_all_by_story_id(params[:story_id])
      @all_histories = @histories.paginate(:page => params[:page], :per_page => 5, :order => "action_time DESC")
    else
      @project = Project.find(params[:project_id])
      @stories = @project.stories.find(:all, :include => [:histories => :user])
      @story_histories = @stories.paginate(:page => params[:page], :per_page => 5, :order => "action_time DESC")
    end
  end
end


