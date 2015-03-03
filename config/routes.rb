Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'
  root 'home#index'
  get '/predictor', to: 'predictor#index'
  get '/privacy', to: 'home#privacy_policy'
end
