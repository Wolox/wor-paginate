class DummyModel < ApplicationRecord
  scope :some_scope, -> { where('something >= 0') }
  has_many :dummy_model_sons, dependent: :nullify

  scope :ocurrences_of_name, lambda {
    select('name, count(*) as count')
      .group('name')
      .order('count desc')
  }
end
