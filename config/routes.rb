Rails.application.routes.draw do

namespace :api do
  namespace :v1 do
    resources :gifts, only: [:create]
    scope ":school_id/" do
      resources :donors, only: [:edit]
      scope '/donors' do
        post '/:donor_id' => 'donors#update'
        get '/:email' => 'donors#show', constraints: { email: /[^\/]+/ }
      end
    end
  end
end

  resources :forms, only: [:create, :show]
  resources :campaigns, only: [:index, :show, :create, :new]
  resources :donors, only: [:index, :show, :update, :edit]
  resources :conversions, only: [:create]
  resources :donor_lists, only: [:index, :show, :create, :new, :update]

end
