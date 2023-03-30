class CarsController < ApplicationController
  before_action :find_car, only: %i[show]

  def index
    sleep 2
    @cars = Car.all
  end

  def show
    @car = Car.find(params[:id])
    @booking = Booking.new
  end

  private

  def find_car
    @car = Car.find(params[:id])
  end

  def product_params
    params.require(:car).permit(:brand, :model, :address, :year_of_production, :price_per_day, :photo)
  end
end
