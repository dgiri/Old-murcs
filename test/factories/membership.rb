Factory.define :membership do |m|
  m.association :sender, :factory => :user
  m.recipient_email { Factory.next(:email) }
  m.association :project
  m.association :role
  m.token { Digest::SHA1.hexdigest([Time.now, rand].join) }
  m.sent_at { Time.now }
end