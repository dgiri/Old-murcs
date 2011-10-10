class AddDefaultValue0ToPositinInStories < ActiveRecord::Migration
  def self.up
    change_column_default :stories, :position, 0
    Story.find(:all, :conditions => ["position is null"]).each{|s| s.update_attribute(:position, 0)}
  end

  def self.down
    change_column_default :stories, :position, nil
  end
end
