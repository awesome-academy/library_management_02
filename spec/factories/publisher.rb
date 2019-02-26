require "faker"

FactoryBot.define do
  factory :Publisher do |f|
    name{Faker::Name.name}
    description{Faker::String.random}
  end
end
