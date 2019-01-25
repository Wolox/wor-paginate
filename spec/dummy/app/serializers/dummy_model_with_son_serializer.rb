class DummyModelWithSonSerializer < ActiveModel::Serializer
  attributes :id, :name, :something

  has_many :dummy_model_sons
end
