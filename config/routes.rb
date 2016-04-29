Rails.application.routes.draw do

  root 'static_pages#home'

  resources :gifts, only: [:create, :index]

end
