class RenameColumnActionToNewStateAndAddColumnOldStateToHistories < ActiveRecord::Migration
  def self.up
    rename_column :histories, :action, :new_state
    add_column    :histories, :old_state, :string
  end

  def self.down
    rename_column :histories, :new_state, :action
    drop_column   :histories, :old_state
    
  end
end
