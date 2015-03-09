Rails.application.routes.draw do
  match ':status', to: 'errors#show', via: :all, constraints: { status: /\d{3}/ }
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  root 'home#index'
  get '/predictor', to: 'predictor#index'
  get '/test_drive', to: 'predictor#show'
  get '/privacy', to: 'home#privacy_policy'
  get '/events', to: 'events#index', defaults: { format: 'json' }
  get '/city', to: 'cities#data'
  resources :users
end
