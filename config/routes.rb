Rails.application.routes.draw do

  namespace :api do
  	namespace :v1 do
  		resources :gifts, only: [:create, :index]
  	end
  end

  resources :forms, only: [:create, :show]
  resources :campaigns, only: [:index, :show, :create, :new]

end
