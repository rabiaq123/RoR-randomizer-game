Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'application#home'

  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'play' => 'users#play'
  post 'play' => 'users#throw_cup'
  
  resources :users, except: [:index, :edit] # don't allow access to users list and user edit page
end
