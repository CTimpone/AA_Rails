MusicApp::Application.routes.draw do
  resources :users, only: [:new, :create, :show] do
    get 'activate_form'
    post 'activate'
  end

  resource :session, only: [:new, :create, :destroy]
  resources :bands do
    resources :albums, only: :new
  end

  resources :albums, only: [:create, :edit, :show, :destroy, :update] do
    resources :tracks, only: :new
  end

  resources :tracks, only: [:create, :edit, :show, :destroy, :update] do
    resources :notes, only: [:create, :edit, :update, :destroy]
  end

  root 'bands#index'
end
