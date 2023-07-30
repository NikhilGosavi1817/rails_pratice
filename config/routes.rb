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
  resources :avatar, only: [:update, :destroy, :edit]
  resources :profile, only: [:update, :edit]
  # get 'my_profile/update_personal_data', to: 'profile#update_personal_data', as: :update_personal_data
  # patch 'my_profile/update', to: 'profile#update', as: :update_profile
  # get 'user/avatar/edit', to: 'avatar#edit', as:'edit_user_avatar'
  # patch 'user/avatar', to: 'avatar#update'
  # delete 'user/avatar', to: 'avatar#destroy'
end
