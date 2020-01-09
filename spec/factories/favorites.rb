FactoryBot.define do
  factory :favorite do
    sweet_id { Faker::Number.between(from: 1, to: 100) }
    user_id { Faker::Number.between(from: 1, to: 100) }
  end
end
