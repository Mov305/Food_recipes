class RecipeController < ApplicationController
  def index
    # Get all the user's recipes
    @recipes = Recipe.where(user_id: current_user.id)
  end

  def show
    # Get the recipe
    @recipe = Recipe.find(params[:id])
  end

  def new
    # Create a new recipe
    @recipe = Recipe.new
  end

  def create
    # Create a new recipe
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id

    # Save the recipe
    if @recipe.save
      redirect_to @recipe
    else
      redirect_to new_recipe_path
    end
  end

  def general_shopping_list
    # Find all food recipes for the current user but the FoodRcipe does not have a user_id
    @foods = RecipeFood.where(recipe_id: Recipe.where(user_id: current_user.id).pluck(:id)).includes(:food)
    @total_price = 0
    @foods.each do |food|
      @total_price += food.food.price * food.quantity
    end
  end

  private

  def recipe_params
    params.permit(:name, :description, :cooking_time, :preparation_time, :public)
  end
end
