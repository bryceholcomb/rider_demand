Rails.application.routes.draw do
  match ':status', to: 'errors#show', via: :all, constraints: { status: /\d{3}/ }
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root 'home#index'
  get '/predictor', to: 'predictor#index'
  get '/test_drive', to: 'predictor#show'
  get '/privacy', to: 'home#privacy_policy'
  resources :users, except: [:new]
  resources :cities, only: [:index]
  resources :events, only: [:index]
  resources :neighborhoods, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :events, only: [:index]
    end
  end
end
