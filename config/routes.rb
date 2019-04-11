Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :materials, only: [:index, :show]
    end
  end

  resources :materials, only: [:index, :show] do
    member do
      get :datasheet
    end
  end
  resources :manufacturers, only: [:index, :show]
  root to: "root#index"
  # To capture routing error and display error message without trace
  match "*path", :to => "application#routing_error", via: [:get]
  match "*path", :to => "application#posting_error", via: [:post, :put, :patch, :delete]
end
