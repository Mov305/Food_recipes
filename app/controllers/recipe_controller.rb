class RecipeController < ApplicationController
  def index
    # Get all the user's recipes
    @recipes = Recipe.where(user_id: current_user.id)
    @owner = current_user
  end

  def show
    # Get the recipe
    @recipe = Recipe.find(params[:id])
    @owner = current_user
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

  def update
    # Get the recipe and toggle the public attribute
    @recipe = Recipe.find(params[:id])
    @recipe.public = !@recipe.public
    if @recipe.save
      flash[:notice] = 'Recipe was successfully updated.'
    else
      flash[:error] = 'There was an error updating the recipe.'
    end
    redirect_to recipe_path
  end

  def destroy
    # Get the recipe
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      flash[:notice] = 'Recipe was successfully deleted.'
    else
      flash[:error] = 'There was an error deleting the recipe.'
    end
    redirect_to recipe_path
  end

  def general_shopping_list
    # Find all food recipes for the current user but the FoodRcipe does not have a user_id
    @foods = RecipeFood.where(recipe_id: Recipe.where(user_id: current_user.id).pluck(:id)).includes(:food)
    @total_price = 0
    @foods.each do |food|
      @total_price += food.food.price * food.quantity
    end
  end

  def public_recipes
    # Get all the public The public recipes or the recipes that the user created
    @recipes = Recipe.where('public = ? OR user_id = ?', true, current_user.id)
    @owner = current_user
  end


  private

  def recipe_params
    params.permit(:name, :description, :cooking_time, :preparation_time, :public)
  end
end