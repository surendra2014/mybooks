FactoryBot.define do
  factory :book do
    title { Faker::Lorem.word }
    body { Faker::Lorem.characters(100)}
  end
end