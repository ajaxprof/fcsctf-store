Rails.application.routes.draw do
  resources :transactions
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }
  root 'items#index'

  resources :items, only: [:index]
  resources :transactions, only: [:index, :create]
end
