require "faker"

FactoryBot.define do
  factory :Publisher do |f|
    full_name{Faker::Name.name}
    address{Faker::Address.city}
    gender("true")
    phone_number{Faker::Number.number(10)}
    role(1)
  end
end
