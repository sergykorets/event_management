Rails.application.routes.draw do

  
	resources :activities, only: :index
	root 'events#index'

	resources :events do 
		resources :comments
		resources :invites
	end

	devise_for :users
  	
  	post 'user_token' => 'user_token#create'
	namespace :api, defaults:{ format: :json } do
		namespace :v1 do
			devise_scope :user do
			   post "registrations", to: "registrations#create"
			end
			resources :activities, only: :index
			resources :events do 
				resources :invites, only: [:create]
				resources :comments, only: [:create, :update, :destroy]
			end
		end
	end
end
