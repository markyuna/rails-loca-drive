class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :find_user, :database_search
  before_action :find_car, only: %i[show edit update destroy]

  def index
    @cars = Car.all
    if params[:query].present?
      @cars = Car.search_by_address(params[:query])
    else
      @cars = Car.all
    end
      @markers = @cars.geocoded.map do |car|
      {
        lat: car.latitude,
        lng: car.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { car: car }),
        marker_html: render_to_string(partial: "marker", locals: {car: car})
      }
    end
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

  def search
    if params[:query].present?
      @cars = Car.search_by_address(params[:query])
    else
      @cars = Car.all
    end
    @count = @cars.count
    @query = params[:query]

    @markers = @cars.geocoded.map do |car|
      {
        lat: car.latitude,
        lng: car.longitude,
        info_window: render_to_string(partial: "info_window", locals: { car: car }),
        marker_html: render_to_string(partial: "marker", locals: {car: car})
      }
    end
  end

  private

  def find_user
    @user = current_user
  end

  def find_car
    @car = Car.find(params[:id])
  end

  def car_params
    params.require(:car).permit(:brand, :model, :address, :year_of_productionion, :price_per_day, :photo)
  end

  def database_search
    @markers = Car.all
  end
end
