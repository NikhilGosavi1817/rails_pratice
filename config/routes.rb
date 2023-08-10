Rails.application.routes.draw do
  apipie
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get '/student/sign_in', to: 'users/sessions#new'
    post '/student/sign_in', to: 'users/sessions#create', as: 'new_student_session'
  end
  # get 'home/index' nikhil10@gmail.com  8aAfIBa0
  get '/home', to: 'home#index', as: 'home'
  root to: redirect('/home')
  namespace :api do
    namespace :v1 do
      resources :users
    end
  end
  resources :avatar, only: [:update, :destroy, :edit]
  resources :profile, only: [:update, :edit]
  resources :books, only: [:new, :create, :show, :destroy]
  resources :student, only: [:create, :new]
  get 'student_list', to: 'student#list'
  get 'students/active', to: 'student#active'
  put 'students/:id/suspend', to: 'student#suspend', as: :suspend_student
  get 'student/suspended', to: 'student#suspended'
  post 'student/:id/send_reactivation_mail', to: 'student#send_reactivation_mail', as: 'send_reactivation_mail'
  get 'student/:id/reactivate', to: 'student#reactivate', as: 'reactivate_student'
  get 'book_list', to: 'books#list'
  patch 'book/:id/status', to: 'books#archive', as: 'book_status'
  resources :tags
  post 'book/:id/issue', to: 'books#issue', as: 'book_issue'
  # get 'my_profile/update_personal_data', to: 'profile#update_personal_data', as: :update_personal_data
  # patch 'my_profile/update', to: 'profile#update', as: :update_profile
  # get 'user/avatar/edit', to: 'avatar#edit', as:'edit_user_avatar'
  # patch 'user/avatar', to: 'avatar#update'
  # delete 'user/avatar', to: 'avatar#destroy'
end
