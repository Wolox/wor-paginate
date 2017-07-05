# frozen_string_literal: true
require 'spec_helper'
RSpec.describe Wor::Paginate::Adapters::Adapter do
  describe '#index' do
    context 'when paginating something already paginated' do
      context 'with results' do
        let(:adapter) {  Wor::Paginate::Adapters::Adapter.new(DummyModel, 1, 1) }

        it 'throws error when calling required_methods' do
          expect { adapter.required_methods }.to raise_error(NotImplementedError)
        end
        it 'throws error when calling paginated_content' do
          expect { adapter.paginated_content }.to raise_error(NotImplementedError)
        end
        it 'throws error when calling count' do
          expect { adapter.count }.to raise_error(NotImplementedError)
        end
        it 'throws error when calling total_count' do
          expect { adapter.total_count }.to raise_error(NotImplementedError)
        end
      end
    end
  end
end
