class User < ActiveRecord::Base
  acts_as_authentic do |config|
    config.validate_login_field = false
    config.validate_email_field = false
    config.validate_password_field = false
  end
  
  def self.find_by_username_or_email(login)
    find_by_username(login) || find_by_email(login)
  end  
  
  attr_accessor :current_project_id 
  
  has_many :requested_stories , :class_name => 'Story', :foreign_key  => 'requested_by_id' 
  has_many :owned_stories , :class_name => 'Story', :foreign_key  =>  'owned_by_id' 
  has_many :sent_memberships, :class_name => 'Membership', :foreign_key => 'sender_id'
  has_many :memberships
  has_many :projects, :through => :memberships
  has_many :comments
  has_many :tasks
  has_many :histories
  
  validates_presence_of       :username, :email, :password
  validates_uniqueness_of     :username, :email
  validates_format_of         :username, :with => Authlogic::Regex.login, :allow_blank => true
  validates_length_of         :username, :within => 3..20, :allow_blank => true
  validates_format_of         :email, :with => Authlogic::Regex.email, :allow_blank => true
  validates_length_of         :email, :within => 6..60, :allow_blank => true
  validates_length_of         :password, :minimum => 4, :allow_blank => true
  validates_confirmation_of   :password, :allow_blank => true
  
  def role_symbols
    ActiveRecord::Base.logger.info "current_project_id: #{current_project_id}"
    membership = memberships.find_by_project_id_and_user_id(current_project_id, self)
    if membership && membership.role
      [membership.role.title.downcase.to_sym]
    else
      []
    end
  end
  
  def full_name
    "#{username}"
  end
end
