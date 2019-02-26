FactoryBot.define do
  factory :author do |f|
    name{Faker::Name.name}
    description{Faker::String.random}
  end
end
