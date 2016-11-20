Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users

  namespace :v1 do
    mount_devise_token_auth_for 'User', at: 'users'

    resources :recipes, except: [:new, :edit]
  end
end
