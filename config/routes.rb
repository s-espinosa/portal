Rails.application.routes.draw do
  namespace :instructors do
    resources :projects, only: [:new, :create, :show]
  end
end
