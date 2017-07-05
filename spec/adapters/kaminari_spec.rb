# frozen_string_literal: true
require 'spec_helper'
RSpec.describe Wor::Paginate::Adapters::Kaminari do
  describe '#index' do
    let!(:n) { 28 }
    let!(:n_page) { 25 }
    let!(:dummy_models) { create_list(:dummy_model, n) }
    context 'when paginating something already paginated' do
      context 'with results' do
        let!(:paginated) { DummyModel.paginate(page: 1) }
        let(:adapter) {  Wor::Paginate::Adapters::Kaminari.new(paginated, 1, n_page) }
        before do
          allow_any_instance_of(ActiveRecord::Relation).to receive(:per)
            .and_return(DummyModel.page(1))
        end
        it 'responds to count' do
          expect(adapter.count).to be n_page
        end

        it 'responds to required_methods' do
          expect(adapter.required_methods).not_to be_empty
        end

        it 'responds to total_count' do
          expect(adapter.total_count).to be n
        end

        it 'responds to total_pages' do
          expect(adapter.total_pages).to be 2
        end

        it 'responds to paginated_content' do
          expect(adapter.paginated_content.class).to be paginated.class
        end
      end
    end
  end
end
