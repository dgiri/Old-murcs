class Task < ActiveRecord::Base
  belongs_to :story
  belongs_to :user
  
  validates_presence_of :description    
end
