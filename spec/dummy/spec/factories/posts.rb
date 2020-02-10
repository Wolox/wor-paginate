FactoryGirl.define do
  factory :post do
    title { Faker::Book.title }
    body { Faker::Lorem.paragraph }
  end
end
