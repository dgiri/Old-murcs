authorization do    
  role :admin do
    has_permission_on :projects, :to => [ :read, :manage ]
    has_permission_on :memberships, :to => [ :read, :manage ]
    has_permission_on :stories, :to => [ :read, :manage, :change_state, :update_status ]
  end
  
  role :member do
    has_permission_on :projects, :to => [ :read, :tracker_column ]  
    has_permission_on :stories, :to => [ :read ]  
    has_permission_on :memberships, :to => [ :read ]     
  end
  
  role :viewer do
    has_permission_on :projects, :to => [ :read, :tracker_column]
  end
  
  role :guest do
    has_permission_on :projects, :to => [ :read, :new, :create]
    has_permission_on :user, :to => [ :new, :create ]
  end
end

privileges do
  privilege :read do
    includes :index, :show
  end
  
  privilege :manage do
    includes :new, :create, :edit, :update, :destroy, :tracker_column
  end
end