class Project < ActiveRecord::Base
  ITERATION_LENGTH = 7
  
  has_many :stories
  has_many :memberships
  has_many :users, :through => :memberships
  
  validates_presence_of :name 
  validates_uniqueness_of :name
  
  def set_owner(user)
    owner = memberships.build(:user => user, :accepted_at => Time.now, :role => Role::ADMIN)
    owner.save(false)
  end
end
