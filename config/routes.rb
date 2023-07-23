Rails.application.routes.draw do
  apipie
  devise_for :users
  # get 'home/index'
  get '/home', to: 'home#index', as: 'home'
  root to: redirect('/home')
  namespace :api do
    namespace :v1 do
      resources :users
    end
  end
end
