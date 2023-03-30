class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_booking, only: %i[show]
  before_action :set_car, only: %i[new create]

  def index
    @bookings = Booking.all
    @my_bookings = Booking.where(user_id: current_user.id)
  end

  def new
    @booking = Booking.new
    @car = Car.find(params[:car_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.user_id = @user.id
    @booking.car_id = @car.id
    @booking.total_price = ((@booking.ends_at - @booking.starts_at).to_i) * @car.price_per_day
    if @booking.save
      redirect_to @car, notice: "Votre réservation a été créée avec succès."
    else
      render :new
    end
  end


  private

  def set_car
    @car = Car.find(params[:car_id])
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def booking_params
    params.require(:booking).permit(:starts_at, :ends_at)
  end
end
