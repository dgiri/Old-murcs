class AddUserIdToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :user_id, :string
  end

  def self.down
    remove_column :projects, :user_id
  end
end
