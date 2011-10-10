class HomeController < ApplicationController
  # skip_before_filter :require_user, :set_current_project_id
  
  def index
    @projects = current_user.projects 
    @histories = History.paginate(:page => params[:page], :per_page => 10, :order => "action_time DESC")
  end
end
