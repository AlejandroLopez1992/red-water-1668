class DishIngredientsController < ApplicationController

  def create
    @dish = Dish.find(params[:dish_id])
    @chef = Chef.find(@dish.chef_id)
    @dish_ingredient = DishIngredient.new(dish_ingredients_params)
    if @dish_ingredient.save
      redirect_to chef_dish_path(@chef, @dish)
    end
  end

  private
    def dish_ingredients_params
      params.permit(:dish_id, :ingredient_id)
    end
end