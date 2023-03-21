Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "food#index"
  resources "recipes", only: [:index, :show, :new, :create, :destroy]

  # Defines a route called "public_recipes" that will be available at "/public_recipes"
  get "public_recipes", to: "recipes#public_recipes"

  # Defines a route called "general_shopping_list" that will be available at "/general_shopping_list"
  get "general_shopping_list", to: "recipes#general_shopping_list"
end
