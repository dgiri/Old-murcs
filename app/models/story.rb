class Story < ActiveRecord::Base
  include AASM

  STORY_TYPES = ['Bug', 'Feature'].freeze

  ESTIMATE = [0, 1, 2, 3].freeze

  STORY_STATES = {
          :icebox => 'icebox',
          :backlog => 'backlog',
          :started => 'started',
          :finished => 'finished',
          :delivered => 'delivered',
          :accepted => 'accepted',
          :rejected => 'rejected'
  }
  
  # cattr_reader :per_page
  # @@per_page = 1

  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :story_type
  # validates_presence_of :estimate, :unless => Proc.new { |story| story.story_type != 'Feature' }
  
  has_many :comments, :as => :commentable
  has_many :tasks
  has_many :histories
  
  belongs_to :owner, :class_name  => 'User', :foreign_key  => 'owned_by_id'
  belongs_to :requester, :class_name  => 'User', :foreign_key  =>  'requested_by_id'
  belongs_to :project
  
  acts_as_taggable
  
  aasm_column :current_state # defaults to aasm_state
  aasm_initial_state :icebox
  aasm_state :icebox
  aasm_state :backlog
  aasm_state :started
  aasm_state :finished
  aasm_state :delivered
  aasm_state :accepted
  aasm_state :rejected

  aasm_event :to_icebox do
    transitions :to => :icebox, :from => [:backlog, :started]
  end

  aasm_event :to_backlog do
    transitions :to => :backlog, :from => [:icebox, :started]
  end

  aasm_event :start do
    transitions :to => :started, :from => [:backlog, :rejected, :started, :icebox]
  end
  
  aasm_event :finish do
    transitions :to => :finished, :from => [:started]
  end
  
  aasm_event :deliver do
    transitions :to => :delivered, :from => [:finished]
  end
  
  aasm_event :accept do
    transitions :to => :accepted, :from => [:delivered]
  end
  
  aasm_event :reject do
    transitions :to => :rejected, :from => [:delivered]
  end
  
  def story_recipients(project, story)
    User.find( :all, 
               :select => 'email', 
               :conditions => [ "id in (?)", 
                                (project.stories.first.comments.collect(&:user_id).push(story.requested_by_id).push(story.owned_by_id)).uniq
                                ]).collect(&:email)    
  end
  
  def self.update_position(stories, positions)
    positions.each_with_index do |story_id, index|      
      story = stories.detect{|story| story.id == story_id }
      story.update_attribute(:position, index)      
    end    
  end

end
