require 'support/shared_context/default_pagination_params'
require 'support/shared_examples/proper_pagination_params'
require 'spec_helper'

describe DummyModelsController, type: :controller do
  describe '#index' do
    let!(:model_count) { 28 }
    let!(:dummy_models) { create_list(:dummy_model, model_count) }
    let(:expected_list) do
      dummy_models.first(25).map do |dummy|
        { 'id' => dummy.id, 'name' => dummy.name, 'something' => dummy.something }
      end
    end

    context 'when paginating an ActiveRecord with no previous pagination but kaminari installed' do
      before do
        get :index
      end

      include_context 'with default pagination params'

      include_examples 'proper pagination params'

      it 'responds with valid page' do
        expect(response_body(response)['page']).to eq expected_list
      end
    end

    context 'when paginating with page and limit params' do
      context 'with a particular limit passed by option' do
        let(:expected_list) do
          dummy = dummy_models.third
          [{ 'id' => dummy.id, 'name' => dummy.name, 'something' => dummy.something }]
        end
        let(:pagination_params) do
          { page: Wor::Paginate::Config.default_page, count: Wor::Paginate::Config.default_page,
            total_count: model_count, total_pages: model_count, previous_page: 2, current_page: 3,
            next_page: 4 }
        end

        before do
          get :index_with_params
        end

        include_examples 'proper pagination params'

        it 'responds with valid page' do
          expect(response_body(response)['page']).to eq expected_list
        end
      end

      context 'with a really high limit passed by option' do
        let(:expected_list) do
          dummy_models.first(50).map do |dummy|
            { 'id' => dummy.id, 'name' => dummy.name, 'something' => dummy.something }
          end
        end
        let!(:model_count) { 150 }
        let(:pagination_params) do
          { page: 50, count: 50, total_count: model_count, total_pages: 3, previous_page: nil,
            current_page: Wor::Paginate::Config.default_page, next_page: 2 }
        end

        before do
          get :index_with_high_limit
        end

        include_examples 'proper pagination params'

        it 'responds with valid page' do
          expect(response_body(response)['page']).to eq expected_list
        end
      end
    end

    context 'when paginating an ActiveRecord with a scope' do
      before do
        # Requiring both kaminari and will_paginate breaks scope pagination
        get :index_scoped
      end

      include_context 'with default pagination params'

      include_examples 'proper pagination params'

      it 'responds with valid page' do
        expect(response_body(response)['page']).to eq expected_list
      end
    end

    context 'when paginating an ActiveRecord paginated with kaminari' do
      before do
        get :index_kaminari
      end

      include_context 'with default pagination params'

      include_examples 'proper pagination params'

      it 'responds with valid page' do
        expect(response_body(response)['page']).to eq expected_list
      end
    end

    context 'when paginating an ActiveRecord paginated with will_paginate' do
      before do
        get :index_will_paginate
      end

      include_context 'with default pagination params'

      include_examples 'proper pagination params'

      it 'responds with valid page' do
        expect(response_body(response)['page']).to eq expected_list
      end
    end

    context 'when paginating an array' do
      before do
        get :index_array
      end

      include_context 'with default pagination params'

      include_examples 'proper pagination params'

      it 'responds with valid page' do
        expect(response_body(response)['page']).to eq((1..25).to_a)
      end
    end

    context 'when paginating arrays with param page in -1' do
      it 'throws exception' do
        expect do
          get :index_array, params: { page: -1 }
        end.to raise_exception(Wor::Paginate::Exceptions::InvalidPageNumber)
      end
    end

    context 'when paginating arrays with per page in -1' do
      it 'throws exception' do
        expect do
          get :index_array, params: { per: -1 }
        end.to raise_exception(Wor::Paginate::Exceptions::InvalidLimitNumber)
      end
    end

    context 'when paginating something that can\'t be paginated' do
      it 'throws an exception' do
        expect { get :index_exception }
          .to raise_error(Wor::Paginate::Exceptions::NoPaginationAdapter)
      end
    end

    context 'when paginating an ActiveRecord with a custom serializer' do
      before do
        get :index_each_serializer
      end

      let(:expected_list) do
        dummy_models.first(25).map do |dummy|
          { 'something' => dummy.something }
        end
      end

      include_context 'with default pagination params'

      include_examples 'proper pagination params'

      it 'responds with valid page' do
        expect(response_body(response)['page']).to eq expected_list
      end
    end

    context 'when paginating an ActiveRecord with a custom formatter' do
      let(:expected_list) do
        dummy_models.first(25).map do |dummy|
          { 'something' => dummy.something,
            'id' => dummy.id,
            'name' => dummy.name }
        end
      end

      before do
        get :index_custom_formatter
      end

      it 'doesn\'t respond with page in the default key' do
        expect(response_body(response)['page']).to be_nil
      end

      it 'responds with valid page' do
        expect(response_body(response)['items']).to eq expected_list
      end
    end

    context 'when paginating an ActiveRecord with a group by query' do
      let!(:dummy_models) { create_list(:dummy_model, 1, name: 'argentina') }
      let!(:dummy_models_2) { create_list(:dummy_model, 2, name: 'uruguay') }
      let!(:dummy_models_3) { create_list(:dummy_model, 3, name: 'costa rica') }

      let(:limit) { 2 }

      before do
        get :index_group_by, params: { per: limit }
      end

      it 'responds with a page with expected length' do
        expect(response_body(response)['page'].length).to eq 2
      end

      it 'responds with valid total count' do
        expect(response_body(response)['total_count']).to eq 3
      end
    end

    context 'when paginating with a custom adapter' do
      include_context 'with default pagination params'

      before do
        pagination_params[:count] = pagination_params[:page] = 8
        pagination_params[:total_pages] = 4
        get :index_custom_adapter
      end

      let(:expected_list) { dummy_models.first(8).as_json(only: %i[id name something]) }

      include_examples 'proper pagination params'

      it 'responds with valid page' do
        expect(response_body(response)['page']).to eq expected_list
      end
    end

    context 'when deleting all the adapters' do
      before { Wor::Paginate::Config.clear_adapters }

      after { Wor::Paginate::Config.reset_adapters! }

      it 'throws NoPaginationAdapter exception' do
        expect { get :index }
          .to raise_exception(Wor::Paginate::Exceptions::NoPaginationAdapter)
      end
    end

    context 'when removing and adding some adapters' do
      include_context 'with default pagination params'

      before do
        config.remove_adapter(Wor::Paginate::Adapters::WillPaginate)
        config.remove_adapter(Wor::Paginate::Adapters::Kaminari)
        config.remove_adapter(Wor::Paginate::Adapters::ActiveRecord)
        config.add_adapter(CustomAdapter)
        pagination_params[:count] = pagination_params[:page] = 8
        pagination_params[:total_pages] = 4
        get :index
      end

      after { Wor::Paginate::Config.reset_adapters! }

      let(:config) { Wor::Paginate::Config }

      let(:expected_list) { dummy_models.first(8).as_json(only: %i[id name something]) }

      include_examples 'proper pagination params'

      it 'paginates with the behaviour of the remaining adapter that adapts' do
        expect(response_body(response)['page']).to eq expected_list
      end
    end
  end
end
