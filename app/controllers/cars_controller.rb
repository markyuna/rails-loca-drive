class CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def show
    @car = Car.find(params[:id])
    @booking = Booking.new
  end

  private

  def product_params
    params.require(:car).permit(:brand, :model, :address, :year_of_production, :price_per_day, :photo)
  end
end
