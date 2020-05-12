Rails.application.routes.draw do
  root :to => 'static_pages#home'

  # Navigation
  get '/home' => 'static_pages#home'
  get '/login' => 'sessions#new'
  get '/about' => 'static_pages#about'
  get '/userhome' => 'static_pages#userhome'

  # Authentication
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy' 

  # User management
  get '/users' => 'users#index'
  get '/users/new' => 'users#new'
  post '/users/new' => 'users#create'
  get '/users/edit' => 'users#edit'
  post '/users/edit' => 'users#update'

  # Manager management
  get '/managers' => 'managers#index'
  get '/managers/new' => 'managers#new'
  post '/managers/new' => 'managers#create'
  get '/managers/edit' => 'managers#edit'
  post '/managers/edit' => 'managers#update'

  # Boatlog management
  get '/boatlogs' => 'boatlogs#index'
  get '/boatlogs/new' => 'boatlogs#new'
  post '/boatlogs/new' => 'boatlogs#create'
  get '/boatlogs/edit' => 'boatlogs#edit'
  post '/boatlogs/edit' => 'boatlogs#update'

  # Surveys
  get "/fishtransects" => 'static_pages#placeholder'
  get "/fishrovers" => 'static_pages#placeholder'
  get "/coralhealths" => 'static_pages#placeholder'

  # Resources
  resources :users
  resources :managers
  resources :boatlogs

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
