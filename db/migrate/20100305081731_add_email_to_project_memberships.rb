class AddEmailToProjectMemberships < ActiveRecord::Migration
  def self.up
    add_column :project_memberships, :email, :string
    
  end

  def self.down
    remove_column :project_memberships, :email, :string
  end
end
