class DummyModelSon < ApplicationRecord
  scope :some_scope, -> { where('something >= 0') }
  has_many :dummy_model_grand_sons, dependent: :nullify
  belongs_to :dummy_model, optional: false
end
