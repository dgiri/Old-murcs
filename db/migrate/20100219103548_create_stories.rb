class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.string :title
      t.string :description
      t.string :story_type
      t.string :current_state

      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end
