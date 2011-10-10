require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  should_have_many :memberships
end
