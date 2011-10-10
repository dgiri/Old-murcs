Factory.define :story do |u|  
  u.project_id "1"
  u.title "Sometitle"
  u.description "Somedescription"
  u.story_type 'bug'
end

Factory.define :icebox_stories, :parent => :story do |t|
  t.current_state 'icebox'
end

Factory.define :backlog_stories, :parent => :story do |t|
  t.current_state 'backlog'
end

Factory.define :indev_stories, :parent => :story do |t|
  t.current_state 'indev'
end

