class CarsController < ApplicationController
  before_action :find_car, only: %i[show edit update destroy]

  def index
    @cars = Car.all
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car = current_user.cars.build(car_params)
    if @car.save
      flash[:notice] = "Voiture mise en vente avec succès !"
      redirect_to @car
    else
      flash[:alert] = "Échec de la mise en vente de la voiture. Veuillez réessayer."
      render :new
    end
  end

  def show
    @car = Car.find(params[:id])
    @booking = Booking.new
  end

  def update
    @car.update(car_params)
    @booking = @car.bookings.find(params[:booking_id])
    redirect_to car_path(@car)
  end

  def destroy
    @car.bookings.destroy_all
    @car.destroy
    redirect_to my_cars_path
  end

  def my_cars
    @cars = current_user.cars
    @bookings = @cars.map {|p| p.bookings}.flatten
  end

  private

  def find_user
    @user = current_user
  end

  def find_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:brand, :model, :address, :year_of_production, :price_per_day, :photo)
  end
end
