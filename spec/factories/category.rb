FactoryBot.define do
  factory :category do |f|
    name{Faker::Name.name}
  end
end
