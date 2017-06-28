FactoryGirl.define do
  factory :dummy_model do
    name { rand(36*4).to_s(36) }
    something  { rand(100) }
  end
end
