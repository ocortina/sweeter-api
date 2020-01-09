FactoryBot.define do
  factory :relation do
    follower_id { Faker::Number.between(from: 1, to: 100) }
    following_id { Faker::Number.between(from: 1, to: 100) }
  end
end

