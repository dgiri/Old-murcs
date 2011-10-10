class RemoveLabelFromStories < ActiveRecord::Migration
  def self.up
    remove_column :stories, :label
  end

  def self.down
    add_column :stories, :label, :string
  end
end
