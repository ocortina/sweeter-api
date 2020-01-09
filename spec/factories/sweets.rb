FactoryBot.define do
  factory :sweet do
    description { Faker::Quote.famous_last_words }
    user_id { Faker::Number.between(from: 1, to: 10) }
  end
end