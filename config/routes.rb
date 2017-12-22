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
  get 'user_profile' => 'admin/users#user_profile'
  post 'user_profile_update' => 'admin/users#user_profile_update'
  get 'user_preferences' => 'admin/users#user_preferences'
  post 'user_preferences_update' => 'admin/users#user_preferences_update'
  post 'user_preferences_avatar_update' => 'admin/users#user_preferences_avatar_update'
  get 'user_security' => 'admin/users#user_security'
  post 'user_security_update' => 'admin/users#user_security_update'

  get 'admin/' => redirect('/')
  get 'admin/dashboard' => 'admin#dashboard'
end
