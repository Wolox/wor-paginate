FactoryGirl.define do
  factory :dummy_model_son do
    name { rand(36 * 4).to_s(36) }
    something { rand(100) }

    after(:create) do |dummy_model_son, _evaluator|
      create(:dummy_model_grand_son, dummy_model_son_id: dummy_model_son.id)
    end
  end
end
