class Car < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  belongs_to :user

  has_many :bookings
  has_one_attached :photo

  validates :brand, :model, :address, presence: true
  validates :price_per_day, numericality: { greater_than: 0 }

end
