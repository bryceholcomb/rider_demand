Rails.application.routes.draw do
  match ':status', to: 'errors#show', via: :all, constraints: { status: /\d{3}/ }
  get '/auth/:provider/callback', to: 'sessions#create'
  root 'home#index'
  get '/predictor', to: 'predictor#index'
  get '/privacy', to: 'home#privacy_policy'
  resources :users
end
