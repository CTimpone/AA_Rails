Rails.application.routes.draw do

  resources :users, only: [:show, :new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :personal_goals
  resource :comment, only: [:new, :create]
end
