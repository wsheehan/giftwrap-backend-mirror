Rails.application.routes.draw do

  namespace :api do
  	namespace :v1 do
  		resources :gifts, only: [:create, :index]
  	end
  end

  resources :forms, only: [:create, :show]
  resources :campaigns, only: [:index, :show, :create, :new]
  resources :donors, only: [:index, :show, :update, :edit]
  resources :conversions, only: [:create]

  get '/donorLists' => "donor_lists#index"
  #resources :donor_lists, only: [:index, :show, :create, :new, :update]

end
