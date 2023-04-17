Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :chefs, only: [:show] do
    resources :dishes, only: [:show]
    resources :ingredients, only: [:index], controller: "chef/ingredients"
  end

  resources :dish_ingredients, only: [:new, :create]
end
