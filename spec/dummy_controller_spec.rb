# frozen_string_literal: true

require 'spec_helper'
RSpec.describe DummyModelsController, type: :controller do
  describe '#index' do
    let!(:dummy_models) { create_list(:dummy_model, 7) }
    let(:expected_list) do
      dummy_models.first(5).map do |dummy|
        { 'id' => dummy.id, 'name' => dummy.name, 'something' => dummy.something }
      end
    end
    context 'when paginating an ActiveRecord with no previous pagination but kaminari installed' do
      before do
        get :index
      end

      it 'responds with items' do
        expect(response_body(response)['items'].length).to be 5
      end

      it 'responds with valid items' do
        expect(response_body(response)['items']).to eq expected_list
      end

      it 'responds with count' do
        expect(response_body(response)['count']).to be 5
      end

      it 'responds with total_count' do
        expect(response_body(response)['total']).to be 7
      end

      it 'responds with page' do
        expect(response_body(response)['page']).to be 1
      end
    end

    context 'when paginating an ActiveRecord model with will_paginate installed' do
      before do
        allow_any_instance_of(Wor::Paginate::Adapters::Kaminari)
          .to receive(:adapt?).and_return(false)
        get :index
      end

      it 'responds with items' do
        expect(response_body(response)['items'].length).to be 5
      end

      it 'responds with valid items' do
        expect(response_body(response)['items']).to eq expected_list
      end

      it 'responds with count' do
        expect(response_body(response)['count']).to be 5
      end

      it 'responds with total_count' do
        expect(response_body(response)['total']).to be 7
      end

      it 'responds with page' do
        expect(response_body(response)['page']).to be 1
      end
    end

    context 'when paginating an ActiveRecord with a scope' do
      before do
        # Requiring both kaminari and will_paginate breaks scope pagination
        get :index_scoped
      end

      it 'responds with items' do
        expect(response_body(response)['items'].length).to be 5
      end

      it 'responds with valid items' do
        expect(response_body(response)['items']).to eq expected_list
      end

      it 'responds with count' do
        expect(response_body(response)['count']).to be 5
      end

      it 'responds with total_count' do
        expect(response_body(response)['total']).to be 7
      end

      it 'responds with page' do
        expect(response_body(response)['page']).to be 1
      end
    end

    context 'when paginating an ActiveRecord paginated with kaminari' do
      before do
        get :index_kaminari
      end

      it 'responds with items' do
        expect(response_body(response)['items'].length).to be 5
      end

      it 'responds with valid items' do
        expect(response_body(response)['items']).to eq expected_list
      end

      it 'responds with count' do
        expect(response_body(response)['count']).to be 5
      end

      it 'responds with total_count' do
        expect(response_body(response)['total']).to be 7
      end

      it 'responds with page' do
        expect(response_body(response)['page']).to be 1
      end
    end

    context 'when paginating an ActiveRecord paginated with will_paginate' do
      before do
        get :index_will_paginate
      end

      it 'responds with items' do
        expect(response_body(response)['items'].length).to be 5
      end

      it 'responds with valid items' do
        expect(response_body(response)['items']).to eq expected_list
      end

      it 'responds with count' do
        expect(response_body(response)['count']).to be 5
      end

      it 'responds with total_count' do
        expect(response_body(response)['total']).to be 7
      end

      it 'responds with page' do
        expect(response_body(response)['page']).to be 1
      end
    end

    context 'when paginating an array' do
      before do
        get :index_array
      end

      it 'responds with items' do
        expect(response_body(response)['items'].length).to be 5
      end

      it 'responds with valid items' do
        expect(response_body(response)['items']).to eq [1, 2, 3, 4, 5]
      end

      it 'responds with count' do
        expect(response_body(response)['count']).to be 5
      end

      it 'responds with total_count' do
        expect(response_body(response)['total']).to be 7
      end

      it 'responds with page' do
        expect(response_body(response)['page']).to be 1
      end
    end

    context 'when paginating something that can\'t be paginated' do
      it 'throws an exception' do
        expect { get :index_exception }
          .to raise_error(Wor::Paginate::Exceptions::NoPaginationAdapter)
      end
    end

    def response_body(response)
      JSON.parse(response.body)
    end
  end
end
