class DropTableProjectMemberships < ActiveRecord::Migration
  def self.up
    drop_table :project_memberships
  end

  def self.down
    create_table :project_memberships do |t|
      t.integer :user_id
      t.integer :project_id
      t.string  :role

      t.timestamps
    end
  end
end
