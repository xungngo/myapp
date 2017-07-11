Rails.application.routes.draw do
  # This hook allows the DRF to attach routes to the application's routes list.
  # it should appear at the top of the routes.rb file.
  DiditRailsFramework.setup_routes(self)

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
