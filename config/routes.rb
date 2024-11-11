Rails.application.routes.draw do
  root "polls#index"

  namespace :admin do
    get 'login', to: 'admin_sessions#new', as: :login
    post 'login', to: 'admin_sessions#create'
    get 'logout', to: 'admin_sessions#destroy', as: :logout
    delete 'logout', to: 'admin_sessions#destroy'

    resources :polls do
      member do
        post 'toggle_status'
        post 'duplicate'
      end
    end
  end

  resources :polls, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    member do
      post 'vote'
      post 'duplicate'
    end
  end
end
