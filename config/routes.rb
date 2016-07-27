Rails.application.routes.draw do

namespace :api do
  namespace :v1 do
    resources :gifts, only: [:create]
    resources :donors, only: [:show, :edit]
    scope ":school_id/donors" do
      post '/:id' => 'donors#update'
      get '/:email' => 'donors#show', constraints: { email: /[^\/]+/ }
    end
  end
end

  resources :forms, only: [:create, :show]
  resources :campaigns, only: [:index, :show, :create, :new]
  resources :donors, only: [:index, :show, :update, :edit]
  scope "/donors" do
    post "/find_by_email" => "donors#show"
  end
  resources :conversions, only: [:create]
  resources :donor_lists, only: [:index, :show, :create, :new, :update]

end
