class FoodController < ApplicationController
  before_action :set_food, only: %i[show edit update destroy]

  def index
    @foods = Food.where(user_id: current_user.id)
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)
    @food.user_id = current_user.id

    if @food.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    @food = Food.find(params[:id])
    authorize! :destroy, @food
  
    if @food.destroy
      flash[:notice] = "Food was successfully deleted."
    else
      flash[:error] = "There was an error deleting the food."
      render :show, status: 400
    end
  end
  
  private
    def food_params
      params.require(:food).permit(:name)
    end
end
