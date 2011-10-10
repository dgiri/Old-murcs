class RenameColumnRoleTypeToTitleInRoles < ActiveRecord::Migration
  def self.up
    rename_column :roles, :role_type, :title
  end

  def self.down
    rename_column :roles, :title, :role_type
  end
end
