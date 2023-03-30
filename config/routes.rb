Rails.application.routes.draw do
  get 'bookings/create'
  get 'cars/index'
  get 'cars/show'
  devise_for :users
  root to: "pages#home"

  resources :cars, only: [:index, :show]
  resources :bookings, only: [:create]
end
