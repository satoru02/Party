Rails.application.routes.draw do

  root to: 'home#index'
  # resources :users

  namespace 'api' do
    namespace 'v1' do
      resources :posts do
        collection do
          get :search
        end
      end
    end
  end
end
