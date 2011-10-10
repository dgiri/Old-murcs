require 'test_helper'

class ProjectTest < ActiveSupport::TestCase  
  should_have_many :memberships
  should_have_many :users, :through => :memberships
  should_have_many :stories
  
  should_validate_presence_of :name

end
