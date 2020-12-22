Rails.application.routes.draw do

  root to: 'home#index'

  namespace 'api' do
    namespace 'v1' do
      resources :users
      resources :posts do
        collection do
          get :search
        end
      end
    end
  end
  get '*path', to: 'home#index'
end
