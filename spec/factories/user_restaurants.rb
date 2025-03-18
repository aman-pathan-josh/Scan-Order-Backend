FactoryBot.define do
  factory :user_restaurant do
    association :user
    association :restaurant
  end
end
