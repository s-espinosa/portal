Rails.application.routes.draw do
  get 'login', to:'sessions#new'
  get 'auth/:provider/callback', to: 'sessions#create'

  namespace :instructors do
    resources :projects, only: [:new, :create, :show]
    get '/dashboard', to: 'dashboard#show'
  end

  get '/dashboard', to: 'dashboard#show'
end
