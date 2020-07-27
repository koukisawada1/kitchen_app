Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'homes#top'
  get 'about' => 'homes#about'
  get 'search' => 'recipes#search'
  post '/homes/guest_sign_in', to: 'homes#new_guest'

  resources :notifications, only: [:index] do
    collection do
      delete :destroy_all
    end
  end

  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
  end

  resources :recipes do
    resource :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    member do
      get :confirm
    end
    collection do
      get :rank_index
      get :new_index
    end
  end
end
