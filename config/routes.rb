Rails.application.routes.draw do
  root 'pages#home', id: 'home'

  # Other Pages
  get '/home', to: redirect('/')

  get 'admin/' => redirect('/')
  get 'admin/dashboard' => 'admin#dashboard'

  namespace :admin do
    resources :locations
    resources :users
  end

end
