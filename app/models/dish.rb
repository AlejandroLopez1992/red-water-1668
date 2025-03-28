class Dish < ApplicationRecord
  validates_presence_of :name, :description
  belongs_to :chef
  has_many :dish_ingredients
  has_many :ingredients, through: :dish_ingredients

  def sum_calories
   ingredients.sum(:calories)
  end

  def chef_name
    chef.name
  end
end