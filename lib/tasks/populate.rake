namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    [User, Story].each(&:delete_all)
    
    User.populate 20 do |user|
      user.username = Faker::Name.first_name
      user.email = Faker::Internet.email
      user.crypted_password = 'd5afbb1425ee6f019bc538a8285c93808d244f39daf35bce9e052c55c7746854f065a05f1a2495857f87337959989d026ff39ddfdc06b886709bb2adb6b42769'
      user.password_salt = '8DXc7VEE-ZovFYtX50jj'
      user.persistence_token = '8f70f279f14761847fda51341e822ddaac33a8f0aa2c5252ff6bbffdd3fc6c16fbbd91811bad73447e0f13855cac43798088188565cd518a1849c9e2b8cdce09'
      user.created_at = Time.now
      user.updated_at = Time.now
    end
    
    Story.populate 5 do |story|
      story.title = Faker::Lorem.words
      story.description = Faker::Lorem.sentence
      story.story_type = Story::STORY_TYPES.rand
      story.current_state = 'icebox'
      story.created_at = Time.now
      story.updated_at = Time.now
    end
  end
end