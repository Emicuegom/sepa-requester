Rails.application.routes.draw do
  apipie
  resources :users, param: :_username
  resources :payment_requests, only: [:index, :create, :show]
  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end
