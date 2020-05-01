Rails.application.routes.draw do
  root :to => 'static_pages#home'

  # Navigation
  get 'home' => 'static_pages#home'
  get 'login' => 'sessions#new'
  get 'about' => 'static_pages#about'

  get 'userhome' => 'static_pages#userhome'
  get 'manageuser' => 'users#index'

  # Authentication
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy' 

  # User management
  get 'manageuser/new' => 'users#new'
  post 'manageuser/new' => 'users#create'
  get 'manageuser/edit' => 'users#edit'
  post 'manageuser/edit' => 'users#update'

  # Resources
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
