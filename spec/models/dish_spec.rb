require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end
  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many :dish_ingredients}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end

  before(:each) do
    @chef = Chef.create(name: "Mr. Johnson")
    @chef_2 = Chef.create(name: "Mr. Burger")
    @dish_1 = @chef.dishes.create(name: "Spagetti", description: "Noodles and meatballs in red sauce")
    @dish_2 = @chef.dishes.create(name: "Tacos", description: "Steak, cilantro and onion in a tortilla")
    @dish_3 = @chef_2.dishes.create(name: "Burger", description: "Patty and veggies inside of a bun with cheese")
    @ingredient_1 = Ingredient.create(name: "noodles", calories: 175)
    @ingredient_2 = Ingredient.create(name: "meatballs", calories: 300)
    @ingredient_3 = Ingredient.create(name: "red sauce", calories: 125)
    @ingredient_4 = Ingredient.create(name: "steak", calories: 200)
    @ingredient_5 = Ingredient.create(name: "cilantro", calories: 25)
    @ingredient_6 = Ingredient.create(name: "onion", calories: 25)
    @ingredient_7 = Ingredient.create(name: "patty", calories: 400)
    @ingredient_8 = Ingredient.create(name: "veggies", calories: 100)
    @ingredient_9 = Ingredient.create(name: "bun", calories: 250)
    @ingredient_10 = Ingredient.create(name: "cheese", calories: 150)
    @dish_ingredient_1 = DishIngredient.create(dish_id: @dish_1.id, ingredient_id: @ingredient_1.id)
    @dish_ingredient_2 = DishIngredient.create(dish_id: @dish_1.id, ingredient_id: @ingredient_2.id)
    @dish_ingredient_3 = DishIngredient.create(dish_id: @dish_1.id, ingredient_id: @ingredient_3.id)
    @dish_ingredient_4 = DishIngredient.create(dish_id: @dish_1.id, ingredient_id: @ingredient_6.id)
    @dish_ingredient_5 = DishIngredient.create(dish_id: @dish_2.id, ingredient_id: @ingredient_4.id)
    @dish_ingredient_6 = DishIngredient.create(dish_id: @dish_2.id, ingredient_id: @ingredient_5.id)
    @dish_ingredient_7 = DishIngredient.create(dish_id: @dish_2.id, ingredient_id: @ingredient_6.id)
    @dish_ingredient_8 = DishIngredient.create(dish_id: @dish_3.id, ingredient_id: @ingredient_7.id)
    @dish_ingredient_9 = DishIngredient.create(dish_id: @dish_3.id, ingredient_id: @ingredient_8.id)
    @dish_ingredient_10 = DishIngredient.create(dish_id: @dish_3.id, ingredient_id: @ingredient_9.id)
    @dish_ingredient_11 = DishIngredient.create(dish_id: @dish_3.id, ingredient_id: @ingredient_10.id)
    @dish_ingredient_12 = DishIngredient.create(dish_id: @dish_3.id, ingredient_id: @ingredient_3.id)
  end

  describe 'instance methods' do
    describe '.sum_calories' do
      it 'sums the calories of all ingredients for a dish' do
        expect(@dish_1.sum_calories).to eq(625)
        expect(@dish_2.sum_calories).to eq(250)
      end
    end

    describe '.chef_name' do
      it 'provides the name of the chef for this dish' do
        expect(@dish_1.chef_name).to eq(@chef.name)
      end
    end
  end
end