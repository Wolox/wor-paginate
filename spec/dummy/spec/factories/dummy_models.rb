FactoryGirl.define do
  factory :dummy_model do
    name { rand(36 * 4).to_s(36) }
    something { rand(100) }
  end
  trait :with_son do
    after(:create) do |dummy_model, _evaluator|
      create(:dummy_model_son, dummy_model_id: dummy_model.id)
    end
  end
end
