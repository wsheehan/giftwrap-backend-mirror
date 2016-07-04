Rails.application.routes.draw do

  get 'donors/index'

  get 'donors/show'

  get 'donors/update'

  get 'donors/edit'

  namespace :api do
  	namespace :v1 do
  		resources :gifts, only: [:create, :index]
  	end
  end

  resources :forms, only: [:create, :show]
  resources :campaigns, only: [:index, :show, :create, :new]
  resources :donors, only: [:index, :show, :update, :edit]

end
