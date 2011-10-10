class MembershipsController < ApplicationController
  filter_access_to :edit, :update, :destroy
  
  inherit_resources
  belongs_to :project
    
  create! do |success, failure|
    success.html { redirect_to project_memberships_path(@project) }
  end
  
  protected
    def create_resource(object)
      object.sender = current_user
      object.sent_at = Time.now
      object.save
    end
end
