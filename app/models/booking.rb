class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :car

  validates :starts_at, :ends_at, presence: true

  before_destroy :destroy_user_bookings

  private

  def destroy_user_bookings
    Booking.where(user_id: user_id).destroy_all
  end
end
