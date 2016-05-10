Rails.application.routes.draw do

  root 'static_pages#home'

  namespace :api do
  	namespace :v1 do
  		resources :gifts, only: [:create, :index]
  	end
  end

  resources :forms, only: [:create, :show]

end
