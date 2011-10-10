require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  should_validate_presence_of :title, :description, :story_type  
  should_belong_to :owner, :requester
  
end
