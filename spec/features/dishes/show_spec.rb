require 'rails_helper'

RSpec.describe 'Dish show page' do

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

  describe 'Page Display' do
    it 'should display dishes attributes' do
      visit chef_dish_path(@chef, @dish_1)

      expect(page).to have_content(@dish_1.name)
      expect(page).to have_content(@dish_1.description)
      expect(page).to_not have_content(@dish_2.name)
      expect(page).to_not have_content(@dish_2.description)
      expect(page).to_not have_content(@dish_3.name)
      expect(page).to_not have_content(@dish_3.description)
    end

    it 'should show a list of the dishes ingredients' do
      visit chef_dish_path(@chef, @dish_1)

      within("#dish_ingredients") do
        expect(page).to have_content(@ingredient_1.name)
        expect(page).to have_content(@ingredient_2.name)
        expect(page).to have_content(@ingredient_3.name)
        expect(page).to have_content(@ingredient_6.name)

        expect(page).to_not have_content(@ingredient_10.name)
      end
    end

    it 'should display a total calorie count for the dish based on ingredient calories' do
      visit chef_dish_path(@chef, @dish_1)

      within("#dish_calories") do
        expect(page).to have_content(625)
      end

      visit chef_dish_path(@chef, @dish_2)

      within("#dish_calories") do
        expect(page).to have_content(250)
      end
    end

    it 'should display the name of the chaf who made this dish' do
      visit chef_dish_path(@chef, @dish_1)
      
      within("#chef_name") do
        expect(page).to have_content(@chef.name)
      end
    end

    it 'has a form to add an ingredient to the dish' do
      visit chef_dish_path(@chef, @dish_1)

      within("#add_ingredient") do
        expect(page).to have_content("Ingredient")
        expect(page).to have_button("Submit")
      end
    end

    it 'when form is filled with existing ingredient ID and submit is clicked page is redirected to dish show page and new ingredient name appears' do
      visit chef_dish_path(@chef, @dish_1)

      within("#dish_ingredients") do
        expect(page).to_not have_content(@ingredient_10.name)
      end

      within("#add_ingredient") do
        fill_in("Ingredient", with: @ingredient_10.id)
        click_button("Submit")

        expect(current_path).to eq(chef_dish_path(@chef, @dish_1))
      end
      
      visit chef_dish_path(@chef, @dish_1)

      within("#dish_ingredients") do
        expect(page).to have_content(@ingredient_10.name)
      end
    end
  end
end