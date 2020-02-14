require 'spec_helper'

describe DummyModelsTotalCountController, type: :controller do
  describe '#index' do
    let!(:dummy_models) { create_list(:dummy_model, 9) }
    let(:expected_list) { dummy_models.first(25).as_json(only: %i[id name something]) }

    context 'when paginating an ActiveRecord with no previous pagination but kaminari installed' do
      before { get :index }

      include_examples 'total count pagination param'

      include_examples 'valid page'
    end

    context 'when paginating with page and limit params' do
      context 'with a particular limit passed by option' do
        let(:expected_list) { [dummy_models.third.as_json(only: %i[id name something])] }

        before { get :index_with_params }

        include_examples 'total count pagination param'

        include_examples 'valid page'
      end

      context 'with a really high limit passed by option' do
        let(:expected_list) { dummy_models.first(50).as_json(only: %i[id name something]) }

        before { get :index_with_high_limit }

        include_examples 'total count pagination param'

        include_examples 'valid page'
      end
    end

    context 'when paginating an ActiveRecord with a scope' do
      before { get :index_scoped }

      include_examples 'total count pagination param'

      include_examples 'valid page'
    end

    context 'when paginating an ActiveRecord paginated with kaminari' do
      before { get :index_kaminari }

      include_examples 'total count pagination param'

      include_examples 'valid page'
    end

    context 'when paginating an ActiveRecord paginated with will_paginate' do
      before { get :index_will_paginate }

      include_examples 'total count pagination param'

      include_examples 'valid page'
    end

    context 'when paginating an array' do
      before { get :index_array }

      include_examples 'total count pagination param'

      it 'responds with valid page' do
        expect(response_body(response)['page']).to eq((1..25).to_a)
      end
    end

    context 'when paginating an ActiveRecord with a custom serializer' do
      before { get :index_each_serializer }

      let(:expected_list) { dummy_models.first(25).as_json(only: %i[something]) }

      include_examples 'total count pagination param'

      include_examples 'valid page'
    end

    context 'when paginating an ActiveRecord with a group by query' do
      let!(:dummy_models) { create_list(:dummy_model, 1, name: 'argentina') }
      let!(:dummy_models_2) { create_list(:dummy_model, 2, name: 'uruguay') }
      let!(:dummy_models_3) { create_list(:dummy_model, 3, name: 'costa rica') }

      before { get :index_group_by, params: { per: 2 } }

      include_examples 'total count pagination param'

      it 'responds with a page with expected length' do
        expect(response_body(response)['page'].length).to eq 2
      end
    end
  end
end
