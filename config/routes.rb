Rails.application.routes.draw do
  root to: 'root#show'
  get 'login', to:'sessions#new'
  get 'logout', to: 'sessions#destroy'
  get 'auth/:provider/callback', to: 'sessions#create'

  namespace :instructors do
    resources :projects, only: [:new, :create, :show, :index] do
      resources :rubrics, only: [:create]
    end
    resources :students, only: [:show] do
      resources :assignments, only: [:create]
    end
    resources :users, only: [:update]
    get '/dashboard', to: 'dashboard#show'
  end

  get '/dashboard', to: 'dashboard#show'
end
