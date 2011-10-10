class AddLabelToStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :label, :string
  end

  def self.down
    remove_column :stories, :label
  end
end
