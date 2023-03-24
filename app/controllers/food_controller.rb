class FoodController < ApplicationController
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

    if @food.destroy
      flash[:notice] = 'Food was successfully deleted.'
      redirect_to root_path
    else
      flash[:error] = 'There was an error deleting the food.'
      render :show, status: 400
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :price, :quantity, :measurement_unit)
  end
end
