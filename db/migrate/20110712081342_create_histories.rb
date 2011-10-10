class CreateHistories < ActiveRecord::Migration
  def self.up
    create_table :histories do |t|
      t.integer :story_id
      t.integer :user_id
      t.string :action
      t.datetime :action_time
    end
  end

  def self.down
    drop_table :histories
  end
end
