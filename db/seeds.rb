# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
#--- cleaning database
puts 'cleaning database'
Booking.destroy_all
Car.destroy_all
User.destroy_all

# puts 'creating users'

# user_attributes = {
#   name: Faker::Internet.username,
#   email: Faker::Internet.email,
#   password: Faker::PhoneNumber.subscriber_number(length: 6)
# }
# users = User.create(user_attributes)

users = User.create!(email: 'marcos@gmail.com', password: 'esternoma')

puts 'database cleaned'

# creating cars

car_sets = [
  { brand: 'Ferrari',
    model: 'Daytona SP3',
    year_of_production: 2021,
    address: '47 rue berger 75001',
    city: 'Paris',
    price_per_day: 54,
    user: users
  },
  { brand: 'Mercedes Benz',
    model: 'Mercedes-Benz GLA',
    year_of_production: 2022,
    address: '16 rue du pont neuf 75001',
    city: 'Paris',
    price_per_day: 64,
    user: users
  },
  { brand: 'Renault',
    model: 'Twingo',
    year_of_production: 2022,
    address: '9 rue mansart 75009',
    city: 'Paris',
    price_per_day: 44,
    user: users
  },
  { brand: 'Toyota',
    model: 'Toyota Corolla',
    year_of_production: 2023,
    address: '60 rue du roi de sicile 75004',
    city: 'Paris',
    price_per_day: 63,
    user: users
  },
  { brand: 'Toyota',
    model: 'Toyota Yaris Hybride',
    year_of_production: 2023,
    address: "59 bis rue jouffroy d'abbans 75017",
    city: 'Paris',
    price_per_day: 83,
    user: users
  },
  { brand: 'Morgan',
    model: 'Plus Six',
    year_of_production: 2023,
    address: "21 rue blondel 75002",
    city: 'Paris',
    price_per_day: 75,
    user: users
  },
  { brand: 'Aston Martin',
    model: 'Aston Martin DB11',
    year_of_production: 2023,
    address: "28 rue jean de la fontaine 75016",
    city: 'Paris',
    price_per_day: 92,
    user: users
  },
  { brand: 'Tesla',
    model: 'Model X Plaid',
    year_of_production: 2023,
    address: "5 Av. Anatole France 75007",
    city: 'Paris',
    price_per_day: 92,
    user: users
  }

]

car_photos = ['voiture_1.jpg', 'mercedesbenz.jpg', 'renault.jpg', 'toyota.jpg', 'yaris.jpg', 'morgan.jpg', 'aston.jpg', 'tesla.jpg']

puts 'creating cars'

car_sets.each_with_index do |car_set, index|
  puts car_set[:brand]
  file = File.open(Rails.root.join("app/assets/images/#{car_photos[index]}"))
  product = Car.new(car_set)
  product.photo.attach(io: file, filename: car_set[:brand], content_type: "image/jpg")
  puts 'photo attached'
  product.save!
end
puts 'cars created'
