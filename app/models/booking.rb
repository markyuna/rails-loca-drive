class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :car

  validates :starts_at, :ends_at, presence: true


  # before_destroy :destroy_user_bookings
  before_save :calculate_total_price

  private

  # def destroy_user_bookings
  #   Booking.where(user_id: user_id).destroy_all
  # end

  def calculate_total_price
    self.total_price = (ends_at - starts_at).to_i * car.price_per_day
  end
end
