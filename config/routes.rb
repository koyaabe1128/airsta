Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :new, :show, :create, :edit, :update] do
    member do
      get :followings
      get :likes
    end
  end
  
  resources :events do
    resources :likes, only: [:create, :destroy]
  end
  
  resources :relationships, only: [:create, :destroy]
  
end
