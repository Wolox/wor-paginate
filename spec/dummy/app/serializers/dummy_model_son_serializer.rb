class DummyModelSonSerializer < ActiveModel::Serializer
  attributes :id, :name, :something

  belongs_to :dummy_model

  has_many :dummy_model_grand_sons
end
