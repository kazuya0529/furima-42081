FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password              { "1a#{Faker::Internet.password(min_length: 4)}" }
    password_confirmation { password }
    last_name             { Faker::Name.last_name }
    first_name            { Faker::Name.first_name }
    last_name_kana        { Faker::Japanese::Name.last_name }
    first_name_kana       { Faker::Japanese::Name.first_name }
    birth_date            { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
