class BookingsController < ApplicationController
  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to root_path, notice: "Booking created successfully."
    else
      render 'cars/show'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:starts_at, :ends_at, :user_id, :car_id)
  end
end
