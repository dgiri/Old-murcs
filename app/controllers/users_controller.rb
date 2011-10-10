class UsersController < ApplicationController
  skip_before_filter :require_user, :set_current_project_id
  before_filter :require_no_user
  before_filter :check_membership, :only => :new
  
  # inherit_resources
  # actions :new, :create
  
  def new
    @user = User.new
    @user.email = @membership.recipient_email if @membership
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = t('flash.users.create.notice')
      check_membership
      redirect_to root_path
    else
      render :action => 'new'
    end
  end
  
  protected
    def check_membership
      return unless params[:membership_token]
      
      @membership = Membership.find_by_token(params[:membership_token]) if params[:membership_token]
      
      redirect_to login_path and return if !@membership || @membership.active?
      
      user = User.find_by_email(@membership.recipient_email)
      
      if user
        @membership.activate!(user)
        flash[:notice] = t('flash.memberships.create.notice')
      end
    end
    
    def create_resource(object)
      object.save
      check_membership
    end
end

