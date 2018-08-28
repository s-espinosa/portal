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

    resources :assignments, only: [] do
      resources :scores, only: [:new, :create]
    end
    resources :turing_cohorts, only: [:index, :show] do
      post '/assignments', to: 'turing_cohort_assignments#create'
    end
    resources :rubrics, only: [:edit, :update, :destroy]
    get '/dashboard', to: 'dashboard#show'

    put   '/turing_cohorts', to: 'turing_cohorts#update'
    patch '/turing_cohorts', to: 'turing_cohorts#update'
    put   '/students/:id', to: 'students#individual_update'
    patch '/students/:id', to: 'students#individual_update'
    put   '/students', to: 'students#update'
    patch '/students', to: 'students#update'
  end

  get '/dashboard', to: 'dashboard#show'
end
