FactoryBot.define do
  factory :transaction do
    invoice_id { nil }
    credit_card_number { "#{Faker::Number.number(digits: 16)}" }
    credit_card_expiration_date { "04/23" }
    result { ["success", "failed"].sample }
  end
end
