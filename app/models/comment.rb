class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  
  validates_presence_of :body
  named_scope :desc_comments, :order => 'created_at desc'     
end
