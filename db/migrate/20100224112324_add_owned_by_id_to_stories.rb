class AddOwnedByIdToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :owned_by_id, :integer
  end

  def self.down
    remove_column :stories, :owned_by_id
  end
end
