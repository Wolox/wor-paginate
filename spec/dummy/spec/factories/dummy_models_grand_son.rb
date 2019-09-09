FactoryGirl.define do
  factory :dummy_model_grand_son do
    name { rand(36 * 4).to_s(36) }
    something { rand(100) }
  end
end
