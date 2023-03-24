class RecipeFoodController < ApplicationController
  def new
    @recipe_food = RecipeFood.new
    @recipe = Recipe.find(params[:recipe_id])
    @foods = Food.where(user_id: current_user.id)
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    @recipe_food.food_id = params[:recipe_food][:food_id]
    @recipe_food.recipe_id = params[:recipe_id]

    p @recipe_food
    if @recipe_food.save
      redirect_to recipe_path(params[:recipe_id])
      flash[:notice] = 'Recipe food was successfully created.'
    else
      redirect_to new_recipe_recipe_food_path(params[:recipe_id])
      # reload the page

      respond_to do |format|
        format.js { render inline: 'location.reload();' }
      end

      flash[:error] = 'There was an error creating the recipe food.'
    end
  end

  def destroy
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe_food.destroy
      flash[:notice] = 'Recipe food was successfully deleted.'
    else
      flash[:error] = 'There was an error deleting the recipe food.'
    end
    redirect_to recipe_path(params[:recipe_id])
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity)
  end
end
