Rails.application.routes.draw do
  root to: 'root#show'
  get 'login', to:'sessions#new'
  get 'auth/:provider/callback', to: 'sessions#create'

  namespace :instructors do
    resources :projects, only: [:new, :create, :show] do
      resources :rubrics, only: [:create]
    end
    get '/dashboard', to: 'dashboard#show'
  end

  get '/dashboard', to: 'dashboard#show'
end
