Rails.application.routes.draw do
  root to: 'home#index'

  namespace :api do
    scope module: :v1, constraints: ApiConstraint.new(version: :v1) do
      mount_devise_token_auth_for 'User', at: 'users'

      resources :recipes, except: [:new, :edit] do
        member do
          post :add_ingredients
          post :add_directions
        end

        collection do
          get :completed
          get :feeds
        end
      end

      resource :completes, only: [:create, :destroy]
      resources :reviews, only: [:create, :destroy]
    end
  end
end
