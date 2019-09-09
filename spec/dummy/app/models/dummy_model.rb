class DummyModel < ApplicationRecord
  scope :some_scope, -> { where('something >= 0') }
  has_many :dummy_model_sons, dependent: :nullify
end
