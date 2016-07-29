Rails.application.routes.draw do

  namespace :campaigns do
    get 'demos/new'
  end

  namespace :campaigns do
    get 'demos/create'
  end

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
  resources :campaigns, only: [:index, :show]
  resources :donors, only: [:index, :show, :update, :edit]
  resources :conversions, only: [:create]
  resources :donor_lists, only: [:index, :show, :create, :new, :update]

  namespace :campaigns do
    resources :texts, only: [:index, :show, :create]
    resources :emails, only: [:index, :show, :create]
    resources :demos, only: [:new, :create]
  end

end
