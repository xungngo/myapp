Rails.application.routes.draw do
  root 'pages#home', id: 'home'

  # Other Pages
  get '/home', to: redirect('/')
  get '/aboutus', to: 'pages#aboutus'
  get '/search1', to: 'pages#search1'
  get '/search', to: 'pages#search'
  get '/search_result', to: 'pages#getmarkers'
  get '/signin', to: 'pages#signin'
  get '/signin_result', to: 'pages#signin_result'
  get '/register', to: 'pages#register'
  get '/register_result', to: 'pages#register_result'
  get '/forgot', to: 'pages#forgot'
  get 'user' => 'admin/users#user_home'

  get 'admin/' => redirect('/')
  get 'admin/dashboard' => 'admin#dashboard'
end
