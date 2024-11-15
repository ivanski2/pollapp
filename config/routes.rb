Rails.application.routes.draw do
  devise_for :administrators
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root "polls#index"

  namespace :admin do
    devise_for :administrators, skip: [:passwords]

    resources :polls do
      member do
        post 'toggle_status'
        post 'duplicate'
      end
    end

    get 'login', to: 'admin_sessions#new', as: :login
    post 'login', to: 'admin_sessions#create'
    delete 'logout', to: 'admin_sessions#destroy', as: :logout
  end

  resources :polls, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    member do
      post 'vote'
      post 'duplicate'
    end
  end
end
