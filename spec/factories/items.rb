FactoryBot.define do
  factory :item do
    name { Faker::ElectricalComponents.electromechanical }
    description { Faker::Company.bs }
    unit_price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    merchant_id { nil }
  end
end
