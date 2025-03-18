FactoryBot.define do
  factory :restaurant do
    restaurant_name { Faker::Restaurant.name }
    address { Faker::Address.full_address }
    contact { Faker::PhoneNumber.subscriber_number(length: 10) }
  end
end
