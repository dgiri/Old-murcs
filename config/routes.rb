ActionController::Routing::Routes.draw do |map|
  SprocketsApplication.routes(map) 
  
  map.root :controller => "home"

  map.resources :users 
  map.resources :roles
  map.resources :comments
  map.resource :user_sessions
  #map.resources :tasks, :collection => {:update_task_status => :get}
  
  map.resources :projects, :member => {:tracker_column => :get} do |project|
    project.resources :stories, :member => {:change_state => :put, :update_status => :put} do |story|
      story.resources :histories
      story.resources :tasks, :collection => {:update_task_status => :get}
    end  
    project.resources :memberships
    project.resources :histories
  end
  
  map.signup "signup/:membership_token", :controller => "users", :action => "new", :membership_token => nil
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
end

