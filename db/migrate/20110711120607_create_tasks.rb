class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.text :description
      t.boolean :status, :default => false  
      t.integer :user_id
      t.integer :story_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
