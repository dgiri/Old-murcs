class Role < ActiveRecord::Base
  caches_constants
  
  has_many :memberships
  
end
