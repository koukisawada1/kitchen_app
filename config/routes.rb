Rails.application.routes.draw do
  	devise_for :users
 	 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  	root to: 'homes#top'
  	get 'about' => 'homes#about'

  	resources :users, only: [:show, :edit, :update] do
      resource :relationships,only: [:create, :destroy]
      get 'follower' => 'relationships#follower', as: 'follower'
      get 'followed' => 'relationships#followed', as: 'followed'
  		member do
	  		get :unsubscribe
	  		patch :leave
  		end
  	end

    get 'user_likes' => 'likes#index'
  	resources :recipes do
  		resource :likes, only: [:create, :destroy]
  		resources :comments, only: [:create, :destroy]
  		collection do
  			post :confirm
  		end
      member do
        patch :edit_confirm
      end
  	end

end
