Rails.application.routes.draw do

  root to: 'home#index'

  namespace 'api' do
    namespace 'v1' do
      namespace :admin do
        resources :users, only: [:index]
      end

      resources :signup, only: [:create]
      resources :login, only: [:create, :destroy]
      resources :refresh, only: [:create]
      resources :account_activations, only: [:create] do
        collection do
          post ':token', action: :create
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
          # get ':id', action: :edit, as: :edit
        end
      end

      resources :posts do
        collection do
          get :search
        end
      end
    end
  end

  # fix
  get '/api/v1/users/:id/edit', to:'api/v1/users#edit'
  get '*path', to: 'home#index'
end
