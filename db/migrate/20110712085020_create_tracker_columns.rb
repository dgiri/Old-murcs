class CreateTrackerColumns < ActiveRecord::Migration
  def self.up
    create_table :tracker_columns do |t|
      t.integer :user_id, :null => false
      t.integer :project_id, :null => false
      t.string :tracker_column, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :tracker_columns
  end
end
