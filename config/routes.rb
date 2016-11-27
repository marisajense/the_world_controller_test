Rails.application.routes.draw do
  devise_for :users
  root 'countries#index'
  resources :countries
end
