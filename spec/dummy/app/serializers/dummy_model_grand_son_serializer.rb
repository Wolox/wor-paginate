class DummyModelGrandSonSerializer < ActiveModel::Serializer
  attributes :id, :name, :something

  belongs_to :dummy_model_son
end
