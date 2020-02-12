require 'spec_helper'

describe DummySonsController, type: :controller do
  describe '#index' do
    let!(:model_count) { 28 }
    let!(:dummy_models) { create_list(:dummy_model, model_count, :with_son) }
    let(:expected_list) do
      dummy_models.first(25).map do |dummy|
        dummy_son = dummy.dummy_model_sons.first
        dummy_grand_son = dummy.dummy_model_sons.first.dummy_model_grand_sons.first
        { 'id' => dummy.id, 'name' => dummy.name,
          'something' => dummy.something, 'dummy_model_sons' => [
            'id' => dummy_son.id, 'name' => dummy_son.name,
            'something' => dummy_son.something, 'dummy_model_grand_sons' => [
              'id' => dummy_grand_son.id, 'name' => dummy_grand_son.name,
              'something' => dummy_grand_son.something
            ]
          ] }
      end
    end

    context 'when paginating an ActiveRecord with no previous pagination but kaminari installed' do
      before { get :index }

      include_context 'with default pagination params'

      include_examples 'proper pagination params'

      include_examples 'valid page'
    end

    context 'when paginating with page and limit params' do
      context 'with a particular limit passed by option' do
        let(:expected_list) do
          dummy = dummy_models.third
          dummy_son = dummy.dummy_model_sons.first
          dummy_grand_son = dummy.dummy_model_sons.first.dummy_model_grand_sons.first
          [{ 'id' => dummy.id, 'name' => dummy.name,
             'something' => dummy.something, 'dummy_model_sons' => [
               'id' => dummy_son.id, 'name' => dummy_son.name,
               'something' => dummy_son.something, 'dummy_model_grand_sons' => [
                 'id' => dummy_grand_son.id, 'name' => dummy_grand_son.name,
                 'something' => dummy_grand_son.something
               ]
             ] }]
        end
        let(:pagination_params) do
          { page: Wor::Paginate::Config.default_page, count: Wor::Paginate::Config.default_page,
            total_count: model_count, total_pages: model_count, previous_page: 2, current_page: 3,
            next_page: 4 }
        end

        before { get :index_with_params }

        include_examples 'proper pagination params'

        include_examples 'valid page'
      end

      context 'with a really high limit passed by option' do
        let(:expected_list) do
          dummy_models.first(50).map do |dummy|
            dummy_son = dummy.dummy_model_sons.first
            dummy_grand_son = dummy.dummy_model_sons.first.dummy_model_grand_sons.first
            { 'id' => dummy.id, 'name' => dummy.name,
              'something' => dummy.something, 'dummy_model_sons' => [
                'id' => dummy_son.id, 'name' => dummy_son.name,
                'something' => dummy_son.something, 'dummy_model_grand_sons' => [
                  'id' => dummy_grand_son.id, 'name' => dummy_grand_son.name,
                  'something' => dummy_grand_son.something
                ]
              ] }
          end
        end
        let!(:model_count) { 150 }
        let(:pagination_params) do
          { page: 50, count: 50, total_count: model_count, total_pages: 3, previous_page: nil,
            current_page: Wor::Paginate::Config.default_page, next_page: 2 }
        end

        before { get :index_with_high_limit }

        include_examples 'proper pagination params'

        include_examples 'valid page'
      end
    end

    context 'when paginating an ActiveRecord with a scope' do
      # Requiring both kaminari and will_paginate breaks scope pagination
      before { get :index_scoped }

      include_context 'with default pagination params'

      include_examples 'proper pagination params'

      include_examples 'valid page'
    end

    context 'when paginating an ActiveRecord paginated with kaminari' do
      before { get :index_kaminari }

      include_context 'with default pagination params'

      include_examples 'proper pagination params'

      include_examples 'valid page'
    end

    context 'when paginating an ActiveRecord paginated with will_paginate' do
      before { get :index_will_paginate }

      include_context 'with default pagination params'

      include_examples 'proper pagination params'

      include_examples 'valid page'
    end

    context 'when paginating an array' do
      before { get :index_array }

      include_context 'with default pagination params'

      include_examples 'proper pagination params'

      it 'responds with valid page' do
        expect(response_body(response)['page']).to eq((1..25).to_a)
      end
    end

    context 'when paginating arrays with param page in -1' do
      it 'throws exception' do
        expect { get :index_array, params: { page: -1 } }
          .to raise_exception(Wor::Paginate::Exceptions::InvalidPageNumber)
      end
    end

    context 'when paginating arrays with per page in -1' do
      it 'throws exception' do
        expect { get :index_array, params: { per: -1 } }
          .to raise_exception(Wor::Paginate::Exceptions::InvalidLimitNumber)
      end
    end

    context 'when paginating something that can\'t be paginated' do
      it 'throws an exception' do
        expect { get :index_exception }
          .to raise_error(Wor::Paginate::Exceptions::NoPaginationAdapter)
      end
    end

    context 'when paginating an ActiveRecord with a custom serializer' do
      before { get :index_each_serializer }

      include_context 'with default pagination params'

      include_examples 'proper pagination params'

      include_examples 'valid page'
    end

    context 'when paginating an ActiveRecord with a custom formatter' do
      before { get :index_custom_formatter }

      it 'doesn\'t respond with page in the default key' do
        expect(response_body(response)['page']).to be_nil
      end

      it 'responds with valid page' do
        expect(response_body(response)['items']).to eq expected_list
      end
    end
  end
end
