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
  get 'user', to: 'admin/users#user_home'
  get 'user_profile', to: 'admin/users#user_profile'
  post 'user_profile_update', to: 'admin/users#user_profile_update'
  get 'user_preferences', to: 'admin/users#user_preferences'
  post 'user_preferences_update', to: 'admin/users#user_preferences_update'
  post 'user_preferences_avatar_update', to: 'admin/users#user_preferences_avatar_update'
  get 'user_preferences_avatar_delete', to: 'admin/users#user_preferences_avatar_delete'
  get 'user_security', to: 'admin/users#user_security'
  post 'user_security_update', to: 'admin/users#user_security_update'
  # post 'create_event_attachments', to: 'attachments#create'

  get 'admin/', to: redirect('/')
  get 'admin/dashboard', to: 'admin#dashboard'

  resources :attachments
  
  namespace :organizer do
    resources :events do
      post :create_images, :collection => :events
      post :update_image, :collection => :events
      post :delete_image
      post :sort_image
      get  :get_images_json
      get  :status
      post :status_update
      post :status_activate
      post :status_deactivate
      post :status_delete
      post :status_undelete
      post :status_purge
    end
    resources :organizations
  end
end
