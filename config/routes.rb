Rails.application.routes.draw do
  resources :projects
  get "dashboard/index"
  devise_for :users
  resources :admin, as: "projects"
  authenticated :user do
    root "dashboard#index", as: :authenticated_root
  end

  get "home/index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
end
