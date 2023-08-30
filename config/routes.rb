Rails.application.routes.draw do
  resources :qa, only: [:index] do
    collection do
      get 'report_bug', to: 'qa#report_bug'
      post 'create_bug', to: 'developer#create_bug'
      get 'show_projects', to: 'qa#show_projects'
    end
  end
  resources :projects 

  resources :projects do
   get 'delete', on: :member
  end
  

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }

  root to: "projects#index"
  
  resources :bugs do
    member do
      post 'assign_to_myself'
      post 'pick_up'
      post 'mark_resolved'
    end
  end
  

  resources :projects do
    member do
      post 'add_developer'
      delete 'remove_developer/:developer_id', action: :remove_developer, as: :remove_developer
    end
  end
  

end