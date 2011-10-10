class TrackerColumn < ActiveRecord::Base
  has_many :users
  has_many :projects
  
  before_save :before_save_actions
  
  def self.get_opened_columns(user_id, project_id)
    find(:all, 
         :select => 'tracker_column', 
         :conditions => ["user_id = ? and project_id =?", user_id, project_id]
         ).collect(&:tracker_column)
  end
  
  def self.save_opened_column(user_id, project_id, tracker_column)
    create(:user_id => user_id,
           :project_id => project_id,
           :tracker_column => tracker_column) 
    rescue ActiveRecord::StatementInvalid      
      "Record already exists"
  end
  
  def self.remove_closed_column(user_id, project_id, tracker_column)
    find(:first, 
         :conditions => { :user_id => user_id,
                          :project_id => project_id,
                          :tracker_column => tracker_column
                        }).delete
  end
  
  private
  def before_save_actions
    return false unless TrackerColumn.find(:first, 
                                     :conditions => { :user_id => self.user_id,
                                                      :project_id => self.project_id,
                                                      :tracker_column => self.tracker_column 
                                                      }).blank?          
  end
end
