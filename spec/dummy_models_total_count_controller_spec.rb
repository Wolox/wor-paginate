require 'spec_helper'

describe DummyModelsTotalCountController, type: :controller do
  describe '#index' do
    let!(:dummy_models) { create_list(:dummy_model, 28) }
    let(:expected_list) do
      dummy_models.first(25).map do |dummy|
        { 'id' => dummy.id, 'name' => dummy.name, 'something' => dummy.something }
      end
    end

    context 'when paginating an ActiveRecord with no previous pagination but kaminari installed' do
      before do
        get :index
      end

      include_examples 'total count pagination param'

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

        before do
          get :index_with_params
        end

        include_examples 'total count pagination param'

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

        before do
          get :index_with_high_limit
        end

        include_examples 'total count pagination param'

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

      include_examples 'total count pagination param'

      it 'responds with valid page' do
        expect(response_body(response)['page']).to eq expected_list
      end
    end

    context 'when paginating an ActiveRecord paginated with kaminari' do
      before do
        get :index_kaminari
      end

      include_examples 'total count pagination param'

      it 'responds with valid page' do
        expect(response_body(response)['page']).to eq expected_list
      end
    end

    context 'when paginating an ActiveRecord paginated with will_paginate' do
      before do
        get :index_will_paginate
      end

      include_examples 'total count pagination param'

      it 'responds with valid page' do
        expect(response_body(response)['page']).to eq expected_list
      end
    end

    context 'when paginating an array' do
      before do
        get :index_array
      end

      include_examples 'total count pagination param'

      it 'responds with valid page' do
        expect(response_body(response)['page']).to eq((1..25).to_a)
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

      include_examples 'total count pagination param'

      it 'responds with valid page' do
        expect(response_body(response)['page']).to eq expected_list
      end
    end

    context 'when paginating an ActiveRecord with a group by query' do
      let!(:dummy_models) { create_list(:dummy_model, 1, name: 'argentina') }
      let!(:dummy_models_2) { create_list(:dummy_model, 2, name: 'uruguay') }
      let!(:dummy_models_3) { create_list(:dummy_model, 3, name: 'costa rica') }

      before do
        get :index_group_by, params: { per: 2 }
      end

      include_examples 'total count pagination param'

      it 'responds with a page with expected length' do
        expect(response_body(response)['page'].length).to eq 2
      end
    end
  end
end
