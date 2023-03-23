class RecipeFoodController < ApplicationController
  def index
    @foods = Food.where(user_id: current_user.id)
    @recipe = Recipe.find(params[:recipe_id])
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe_food.recipe_id = params[:recipe_id]
    @recipe_food.food_id = params[:food_id]
    if @recipe_food.save
      respond_to do |format|
        format.js {render inline: "location.reload();" }
      end
      redirect_to recipe_path(params[:recipe_id])
      flash[:notice] = "Recipe food was successfully created."
    else
      redirect_to recipe_recipe_food_index_path(params[:recipe_id])
      flash[:error] = "There was an error creating the recipe food."
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe_food.destroy
      flash[:notice] = "Recipe food was successfully deleted."
    else
      flash[:error] = "There was an error deleting the recipe food."
    end
    redirect_to recipe_path(params[:recipe_id])
  end

  private

  def recipe_food_params
    params.permit(:quantity, :food_id, :recipe_id)
  end
end
