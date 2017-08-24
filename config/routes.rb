Rails.application.routes.draw do
  root 'pages#home', id: 'home'

  # Other Pages
  get '/home', to: redirect('/')
  get '/search1', to: 'pages#search1'
  get '/search', to: 'pages#search'
  get '/search_result', to: 'pages#getmarkers'

  get 'admin/' => redirect('/')
  get 'admin/dashboard' => 'admin#dashboard'

  namespace :admin do
    resources :locations
    resources :users
  end

end
