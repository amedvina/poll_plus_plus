Rails.application.routes.draw do
  root "polls#index"

  resources :polls

  resources :votes, only: [:create]
end
