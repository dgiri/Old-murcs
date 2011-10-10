class DropTableUserRoles < ActiveRecord::Migration
  def self.up
    drop_table :user_roles
  end

  def self.down
    create_table "user_roles", :force => true do |t|
      t.integer  "user_id"
      t.integer  "role_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end    
  end
end
