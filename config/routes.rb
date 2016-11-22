Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users

  namespace :api do
    mount_devise_token_auth_for 'User', at: 'users'

    resources :recipes, except: [:new, :edit] do
      member do
        post :add_ingredients
        post :add_directions
      end
    end
  end
end
