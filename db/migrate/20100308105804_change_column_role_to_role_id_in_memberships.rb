class ChangeColumnRoleToRoleIdInMemberships < ActiveRecord::Migration
  def self.up
    remove_column :memberships, :role
    add_column :memberships, :role_id, :integer
  end

  def self.down
    add_column :memberships, :role, :string  
    remove_column :memberships, :role_id   
  end
end
