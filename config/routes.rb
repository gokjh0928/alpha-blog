Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "pages#home"

  get 'about', to: "pages#about"

  # "resources" declares all common routes for a given controller, but can specify chosen routes with "only"
  resources :articles, only: [:show, :index, :new, :create, :edit, :update]
end
