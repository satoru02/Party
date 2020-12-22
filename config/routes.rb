Rails.application.routes.draw do

  root to: 'home#index'

  namespace 'api' do
    namespace 'v1' do
      namespace :admin do
        resources :users, only: [:index]
      end

      resources :signup
      resources :login
      resources :refresh

      resources :users do
        collection do
          get :me
        end
      end

      resources :posts do
        collection do
          get :search
        end
      end
    end
  end

  get '*path', to: 'home#index'
end
