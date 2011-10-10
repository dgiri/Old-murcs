class History < ActiveRecord::Base
  belongs_to :story
  belongs_to :user
  
  # cattr_reader :per_page
  # @@per_page = 10
end
