Rails.application.routes.draw do
  # get 'bookings/create'
  # get 'cars/index'
  # get 'cars/show'
  devise_for :users
  root to: "pages#home"

  resources :cars do
    resources :bookings, only: %i[new create destroy]
  end

  resources :bookings, except: [ :new, :index, :create ] 

  get '/bookings', to: 'bookings#index'
end
