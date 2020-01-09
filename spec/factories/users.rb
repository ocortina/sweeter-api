FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    username { Faker::Games::Pokemon.name }
    email { Faker::Internet.email}
    password 'foobar' #{ Faker::Internet.password(min_length: 5, max_length: 10, mix_case: true) } #=> "3k5qS15aNmG"

  end
end