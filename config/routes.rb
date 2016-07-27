Rails.application.routes.draw do

namespace :api do
  namespace :v1 do
    resources :gifts, only: [:create]
    scope ":school_id/" do
      resources :donors, only: [:edit]
      post '/donors/:donor_id' => 'donors#update'
      get '/donors/:email' => 'donors#show', constraints: { email: /[^\/]+/ }
    end
  end
end

  resources :forms, only: [:create, :show]
  resources :campaigns, only: [:index, :show, :create, :new]
  resources :donors, only: [:index, :show, :update, :edit]
  resources :conversions, only: [:create]
  resources :donor_lists, only: [:index, :show, :create, :new, :update]

end
