FactoryBot.define do
  factory :menu_item do
    item_name { "Pizza" }
    price { 12.99 }
    association :restaurant 
  end
end
