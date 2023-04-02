class Car < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  belongs_to :user

  has_many :bookings
  has_one_attached :photo

  validates :brand, presence: true
  validates :model, presence: true
  validates :year_of_production, presence: true
  validates :address, presence: true

  validates :price_per_day, numericality: { greater_than: 0 }

  include PgSearch::Model
  pg_search_scope :search_by_city_address, against: [ :address ], using: {
    tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
