Rails.application.routes.draw do
  get "login" => "sessions#new"
  get "logout" => "sessions#destroy"
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  resources :wishlists do
    resources :items do# makes routes like 'wishlists/1/items', which should have a page with all the items for the wishlist with id 1
    # => pattern: 'wishlists/:wishlist_id/items/:id'
    	collection do
    		get :search
    	end
    end
  end
  
end
