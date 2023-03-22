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
            render 'new'
        end
    end
end
