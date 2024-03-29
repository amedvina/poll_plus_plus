Rails.application.routes.draw do

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  delete "logout", to: "sessions#destroy"

  root "polls#index"

  resources :polls do
    resources :comments, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :votes, only: [:create]

  resources :posts do
    resources :comments, only: [:new, :create, :edit, :update, :destroy]
  end
end
