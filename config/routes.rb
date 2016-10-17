Rails.application.routes.draw do

  namespace :users do
    resources :authentication, only: :create
  end

  namespace :api do
    namespace :v1 do

      resources :forms, only: [:create, :show]
      namespace :forms do
        resources :gifts, only: :create
        resources :donors, only: [:show, :update, :index]
        resources :client, only: [:show]
      end

      resources :clients, only: [:show]
      resources :gifts, only: [:create, :show, :index, :update]

      resources :donors, only: [:create, :index, :show, :update, :edit]
      namespace :donors do
        get '/find_by_email' => "api/v1/donors#find_by_email"
      end

      resources :donor_lists, only: [:index, :show, :create, :new, :update]

      resources :campaigns, only: [:index, :show]
      namespace :campaigns do
        resources :texts, only: [:index, :show, :create]
        resources :emails, only: [:index, :show, :create]
        resources :demos, only: [:create]
        namespace :texts do
          resources :gifts, only: [:create]
        end
        namespace :emails do
          post '/gifts' => "/griddler/emails#create"
          resources :demos, only: :create
        end
      end

      namespace :metrics do
        namespace :forms do
          resources :conversions, only: :create
        end
      end
    end
  end
end
