class Car < ApplicationRecord
  belongs_to :user

  has_many :bookings
  has_one_attached :photo

  validates :brand, :model, :address, presence: true
  validates :price_per_day, numericality: { greater_than: 0 }
end
