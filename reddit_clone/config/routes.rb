Rails.application.routes.draw do
  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :posts, except: [:index, :destroy] do
    resources :comments, only: :create
  end

  resources :comments, only: [:new, :show]

  resources :subs, except: [:destroy]


  root 'subs#index'
  get '*path' => redirect('/')
end
