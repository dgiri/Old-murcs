class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships do |t|
      t.integer :sender_id
      t.string :recipient_email
      t.integer :project_id
      t.integer :user_id
      t.string :role
      t.string :token
      t.datetime :sent_at, :accepted_at
      t.timestamps
    end
  end

  def self.down
    drop_table :memberships
  end
end
