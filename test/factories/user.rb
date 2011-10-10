Factory.sequence(:username) {|n| "username#{n}"}  
Factory.sequence(:email) {|n| "user#{n}@example.com"}

Factory.define :user do |u|
  u.username { Factory.next(:username) }
  u.email { Factory.next(:email) }
  u.password pw = 'password'
  u.password_confirmation pw
end




  





