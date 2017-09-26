Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  resources :auctions
  resources :products
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'login', to: 'users#login'
  get 'saveAuction', to: 'auctions#saveAuction'
end
