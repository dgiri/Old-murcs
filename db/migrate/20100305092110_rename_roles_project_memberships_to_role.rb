class RenameRolesProjectMembershipsToRole < ActiveRecord::Migration
  def self.up
    rename_column :project_memberships, :roles, :role 
  end

  def self.down
    rename_column :project_memberships, :role, :roles 
  end
end
