Rails.application.routes.draw do
  root to: 'home#index'

  # namespace :api do
  #   scope :v1 do
  #     mount_devise_token_auth_for 'User', at: 'users'
  #
  #     resources :recipes
  #   end
  # end

  mount_devise_token_auth_for 'User', at: 'users'
  resources :recipes
end
