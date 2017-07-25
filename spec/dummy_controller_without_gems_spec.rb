# frozen_string_literal: true
require 'spec_helper'
RSpec.describe DummyModelsWithoutGemsController, type: :controller do
  describe '#index' do
    let!(:dummy_models) { create_list(:dummy_model, 28) }
    let(:expected_list) do
      dummy_models.first(25).map do |dummy|
        { 'id' => dummy.id, 'name' => dummy.name, 'something' => dummy.something }
      end
    end

    before do
      [Wor::Paginate::Adapters::Kaminari, Wor::Paginate::Adapters::WillPaginate].each do |klass|
        allow_any_instance_of(klass).to receive(:adapt?).and_return(false)
      end
    end

    context 'with param page in -1' do
      it 'throws exception' do
        expect do
          get :index, params: { page: -1 }
        end.to raise_exception(Wor::Paginate::Exceptions::InvalidPageNumber)
      end
    end

    context 'With param page in 2' do
      let(:expected_list) do
        dummy_models.slice(25, 25).first(3).map do |dummy|
          { 'id' => dummy.id, 'name' => dummy.name, 'something' => dummy.something }
        end
      end

      before do
        expected_list
        get :index, params: { page: 2 }
      end

      it 'responds with items' do
        expect(response_body(response)['page'].length).to(
          be(DummyModel.count - Wor::Paginate::Config.default_per_page)
        )
      end

      it 'responds with valid items' do
        expect(response_body(response)['page']).to eq expected_list
      end

      it 'responds with count' do
        expect(response_body(response)['count']).to(
          be(DummyModel.count - Wor::Paginate::Config.default_per_page)
        )
      end

      it 'responds with total_count' do
        expect(response_body(response)['total_count']).to be dummy_models.count
      end

      it 'responds with total_pages' do
        total_pages = (dummy_models.count / Wor::Paginate::Config.default_per_page.to_f).ceil
        expect(response_body(response)['total_pages']).to be total_pages
      end

      it 'responds with page' do
        expect(response_body(response)['current_page']).to be 2
      end
    end

    context 'With param page in 1' do
      before do
        get :index, params: { page: 1 }
      end

      it 'responds with items' do
        expect(response_body(response)['page'].length).to(
          be Wor::Paginate::Config.default_per_page
        )
      end

      it 'responds with valid items' do
        expect(response_body(response)['page']).to eq expected_list
      end

      it 'responds with count' do
        expect(response_body(response)['count']).to be Wor::Paginate::Config.default_per_page
      end

      it 'responds with total_count' do
        expect(response_body(response)['total_count']).to be dummy_models.count
      end

      it 'responds with total_pages' do
        total_pages = (dummy_models.count / Wor::Paginate::Config.default_per_page.to_f).ceil
        expect(response_body(response)['total_pages']).to be total_pages
      end

      it 'responds with page' do
        expect(response_body(response)['current_page']).to be Wor::Paginate::Config.default_page
      end
    end

    context 'Without specific page' do
      before do
        get :index
      end

      it 'responds with items' do
        expect(response_body(response)['page'].length).to(
          be Wor::Paginate::Config.default_per_page
        )
      end

      it 'responds with valid items' do
        expect(response_body(response)['page']).to eq expected_list
      end

      it 'responds with count' do
        expect(response_body(response)['count']).to be Wor::Paginate::Config.default_per_page
      end

      it 'responds with total_count' do
        expect(response_body(response)['total_count']).to be dummy_models.count
      end

      it 'responds with total_pages' do
        total_pages = (dummy_models.count / Wor::Paginate::Config.default_per_page.to_f).ceil
        expect(response_body(response)['total_pages']).to be total_pages
      end

      it 'responds with page' do
        expect(response_body(response)['current_page']).to be Wor::Paginate::Config.default_page
      end
    end
  end

  describe '#index_scoped' do
    let!(:dummy_models) { create_list(:dummy_model, 28) }
    let(:expected_list) do
      create_list(:dummy_model, 15, something: -3)
      DummyModel.some_scope.first(25).map do |dummy|
        { 'id' => dummy.id, 'name' => dummy.name, 'something' => dummy.something }
      end
    end

    before do
      [Wor::Paginate::Adapters::Kaminari, Wor::Paginate::Adapters::WillPaginate].each do |klass|
        allow_any_instance_of(klass).to receive(:adapt?).and_return(false)
      end
    end

    context 'with param page in -1' do
      it 'throws exception' do
        expect do
          get :index, params: { page: -1 }
        end.to raise_exception(Wor::Paginate::Exceptions::InvalidPageNumber)
      end
    end

    context 'With param page in 2' do
      let(:expected_list) do
        dummy_models.slice(25, 25).first(3).map do |dummy|
          { 'id' => dummy.id, 'name' => dummy.name, 'something' => dummy.something }
        end
      end

      before do
        expected_list
        get :index, params: { page: 2 }
      end

      it 'responds with items' do
        expect(response_body(response)['page'].length).to(
          be(DummyModel.count - Wor::Paginate::Config.default_per_page)
        )
      end

      it 'responds with valid items' do
        expect(response_body(response)['page']).to eq expected_list
      end

      it 'responds with count' do
        expect(response_body(response)['count']).to(
          be(DummyModel.count - Wor::Paginate::Config.default_per_page)
        )
      end

      it 'responds with total_count' do
        expect(response_body(response)['total_count']).to be dummy_models.count
      end

      it 'responds with total_pages' do
        total_pages = (dummy_models.count / Wor::Paginate::Config.default_per_page.to_f).ceil
        expect(response_body(response)['total_pages']).to be total_pages
      end

      it 'responds with page' do
        expect(response_body(response)['current_page']).to be 2
      end
    end

    context 'With param page in 1' do
      before do
        get :index, params: { page: 1 }
      end

      it 'responds with items' do
        expect(response_body(response)['page'].length).to(
          be Wor::Paginate::Config.default_per_page
        )
      end

      it 'responds with valid items' do
        expect(response_body(response)['page']).to eq expected_list
      end

      it 'responds with count' do
        expect(response_body(response)['count']).to be Wor::Paginate::Config.default_per_page
      end

      it 'responds with total_count' do
        expect(response_body(response)['total_count']).to be dummy_models.count
      end

      it 'responds with total_pages' do
        total_pages = (dummy_models.count / Wor::Paginate::Config.default_per_page.to_f).ceil
        expect(response_body(response)['total_pages']).to be total_pages
      end

      it 'responds with page' do
        expect(response_body(response)['current_page']).to be Wor::Paginate::Config.default_page
      end
    end

    context 'Without specific page' do
      before do
        get :index
      end

      it 'responds with items' do
        expect(response_body(response)['page'].length).to(
          be Wor::Paginate::Config.default_per_page
        )
      end

      it 'responds with valid items' do
        expect(response_body(response)['page']).to eq expected_list
      end

      it 'responds with count' do
        expect(response_body(response)['count']).to be Wor::Paginate::Config.default_per_page
      end

      it 'responds with total_count' do
        expect(response_body(response)['total_count']).to be dummy_models.count
      end

      it 'responds with total_pages' do
        total_pages = (dummy_models.count / Wor::Paginate::Config.default_per_page.to_f).ceil
        expect(response_body(response)['total_pages']).to be total_pages
      end

      it 'responds with page' do
        expect(response_body(response)['current_page']).to be Wor::Paginate::Config.default_page
      end
    end
  end
end
