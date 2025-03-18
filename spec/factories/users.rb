FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.subscriber_number(length: 10) }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Time.now }

    trait :admin do
      after(:create) { |user| user.roles << create(:role, :admin) }
    end
  end
end
