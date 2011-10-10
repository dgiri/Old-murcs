class Membership < ActiveRecord::Base
  ROLES = Role.find(:all, :order => :title).map do |r|
    [r.title, r.id]
  end
  
  belongs_to :sender, :class_name => 'User'
  belongs_to :user
  belongs_to :project
  belongs_to :role
  
  delegate :username, :email, :to => :user   
  
  validates_presence_of :recipient_email, :role_id
  validates_uniqueness_of :recipient_email, :scope => :project_id
  
  before_create :generate_token
  after_create :send_invitation
                           
  def sender_full_name
    sender.full_name  
  end
  
  def member_name
    if user
      "#{username} <#{email}>"
    else
      "#{recipient_email}"
    end
  end
  
  def activate!(user)
     update_attributes(:user => user, :token => nil, :accepted_at => Time.now)
  end
  
  def active?
    !accepted_at.blank?
  end
  
  def self.roles
    Role.find(:all, :order => :title).map do |r|
      [r.title, r.id]
    end
  end
  
  private
    def generate_token
      self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
    end
    
    def send_invitation               
      Notifier.deliver_membership_invitation(self) unless self.recipient_email.blank? 
    end
end
