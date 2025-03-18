FactoryBot.define do
  factory :role do
    trait :superadmin do
      role { "superadmin" }
    end

    trait :admin do
      role { "admin" }
    end

    trait :customer do
      role { "customer" }
    end
  end
end
