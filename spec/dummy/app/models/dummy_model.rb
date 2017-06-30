class DummyModel < ApplicationRecord
  scope :some_scope, -> { where('something > 0') }
end
