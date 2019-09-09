class DummyModelGrandSon < ApplicationRecord
  scope :some_scope, -> { where('something >= 0') }
  belongs_to :dummy_model_son, optional: false
end
