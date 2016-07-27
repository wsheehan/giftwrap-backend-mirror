Rails.application.routes.draw do

  namespace :api do
  	namespace :v1 do
  		resources :gifts, only: [:create]
      resources :donors, only: :show
      post '/donors/:id' => 'donors#update'
  	end
  end

  resources :forms, only: [:create, :show]
  resources :campaigns, only: [:index, :show, :create, :new]
  resources :donors, only: [:index, :show, :update, :edit]
  resources :conversions, only: [:create]
  resources :donor_lists, only: [:index, :show, :create, :new, :update]

  post '/:school_id/find_by_email' => "donors#find_by_email"

end
