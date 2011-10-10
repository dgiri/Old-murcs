class AddRequestedByIdToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :requested_by_id, :integer
  end

  def self.down
    remove_column :stories, :requested_by_id
  end
end
