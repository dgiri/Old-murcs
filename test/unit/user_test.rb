require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should_have_many :requested_stories
  should_have_many :owned_stories
  should_have_many :memberships
  should_have_many :projects, :through => :memberships
  
  should_validate_presence_of     :username, :email, :password
  should_allow_values_for         :username, "foo", "foo1", "foo_1"
  should_not_allow_values_for     :username, "#%^&*~!$^()+="
  should_ensure_length_in_range   :username, (3..20)
  should_allow_values_for         :email, "foo@example.com"
  should_not_allow_values_for     :email, "a@b.c"
  should_ensure_length_in_range   :email, (6..20)
  should_ensure_length_at_least   :password, 4
  
  context "A User" do
    setup do
      Factory(:user)
      subject { User.first }
    end

    should_validate_uniqueness_of :username, :email
  end
  
end
