Rails.application.routes.draw do
  resources :users, only: [:index, :show, :update, :create, :destroy] do
    resources :contacts, only: :index
  end
  resources :contacts, only: [:show, :update, :create, :destroy]
  resources :contact_shares, only: [:index, :show, :update, :create, :destroy]
end
