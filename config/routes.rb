Rails.application.routes.draw do

  root to: 'home#index'
  mount ActionCable.server => "/cable"
  namespace 'api' do
    namespace 'v1' do
      resources :years, only: [:index]
      resources :notifications
      resources :entries, only: [:index, :create]
      resources :entry_responses, only: [:show]
      resources :messages, only: [:show]
      resources :rooms_user, only: [:create, :destroy]
      resources :signup, only: [:create]
      resources :login, only: [:create, :destroy]
      resources :refresh, only: [:create]
      resources :relationships, only: [:create, :destroy]

      resources :account_activations, only: [:create] do
        collection do
          post ':token', action: :create
        end
      end

      resources :tags, only: [:index, :show] do
        collection do
          get ':name', action: :show, as: :show
        end
      end

      resources :password_resets, only: [:create] do
        collection do
          get ':token', action: :edit, as: :edit
          patch ':token', action: :update
        end
      end

      resources :users do
        collection do
          get :me
          get ':id/posts', action: :posts
        end
        member do
          get :following, :followers
        end
      end

      resources :rooms do
        collection do
          get ':token/:user_id', action: :show
        end
      end

      resources :posts do
        collection do
          get :search
          get :popularity
        end
      end

      resources :categories, only: [:index, :show] do
        collection do
          get ':slug', action: :show, as: :show
        end
      end

      namespace :admin do
        resources :users, only: [:index]
      end
    end
  end

  get '/api/v1/users/:id/edit', to:'api/v1/users#edit'
  get '/api/v1/posts/:id/edit', to:'api/v1/posts#edit'
  #local
  get '/rails/active_storage/disk/:encoded_key/*filename', to: 'active_storage/disk#show'
  get '*path', to: 'home#index'
end
