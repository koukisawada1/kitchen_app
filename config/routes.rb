Rails.application.routes.draw do
  	devise_for :users
 	 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  	root to: 'homes#top'
  	get 'about' => 'homes#about'

  	resources :users, only: [:show, :edit, :update] do
  		member do
	  		get :unsubscribe
	  		patch :leave
  		end
  	end

  	resources :recipes do
  		resource :likes, only: [:create, :destroy]
  		resource :comments, only: [:create, :destroy]
  		collection do
  			post :confirm
  			get :like_index
  		end
  	end

end
