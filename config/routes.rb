Rails.application.routes.draw do
  # get 'bookings/create'
  # get 'cars/index'
  # get 'cars/show'
  devise_for :users
  resources :cars, only: %i[destroy]
  root to: "pages#home"

  get 'my_cars', to: 'cars#my_cars'

  resources :cars do
    resources :bookings, only: %i[new create destroy]

    collection do
      get :search
    end

    resources :bookings, only: %i[new create destroy]
  end

  resources :bookings, except: %i[new index create]

  get '/bookings', to: 'bookings#index'
end
