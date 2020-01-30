require 'spec_helper'

describe DummyModelsWithoutGemsController, type: :controller do
  describe '#index' do
    let!(:model_count) { 28 }
    let!(:dummy_models) { create_list(:dummy_model, model_count) }
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

    context 'with param page in 2' do
      before do
        expected_list
        get :index, params: { page: 2 }
      end

      let(:expected_list) do
        dummy_models.slice(25, 25).first(3).map do |dummy|
          { 'id' => dummy.id, 'name' => dummy.name, 'something' => dummy.something }
        end
      end

      include_context 'with param page in 2'

      include_examples 'proper pagination params'

      it 'responds with valid items' do
        expect(response_body(response)['page']).to eq expected_list
      end
    end

    context 'with param page in 1' do
      before do
        get :index, params: { page: 1 }
      end

      include_context 'with default pagination params'

      include_examples 'proper pagination params'

      it 'responds with valid items' do
        expect(response_body(response)['page']).to eq expected_list
      end
    end

    context 'without specific page' do
      before do
        get :index
      end

      include_context 'with default pagination params'

      include_examples 'proper pagination params'

      it 'responds with valid items' do
        expect(response_body(response)['page']).to eq expected_list
      end
    end
  end

  describe '#index_scoped' do
    let!(:model_count) { 28 }
    let!(:dummy_models) { create_list(:dummy_model, model_count) }
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

    context 'with param page in 2' do
      before do
        expected_list
        get :index, params: { page: 2 }
      end

      let(:expected_list) do
        dummy_models.slice(25, 25).first(3).map do |dummy|
          { 'id' => dummy.id, 'name' => dummy.name, 'something' => dummy.something }
        end
      end

      include_context 'with param page in 2'

      include_examples 'proper pagination params'

      it 'responds with valid items' do
        expect(response_body(response)['page']).to eq expected_list
      end
    end

    context 'with param page in 1' do
      before do
        get :index, params: { page: 1 }
      end

      include_context 'with default pagination params'

      include_examples 'proper pagination params'

      it 'responds with valid items' do
        expect(response_body(response)['page']).to eq expected_list
      end
    end

    context 'without specific page' do
      before do
        get :index
      end

      include_context 'with default pagination params'

      include_examples 'proper pagination params'

      it 'responds with valid items' do
        expect(response_body(response)['page']).to eq expected_list
      end
    end
  end

  describe '#index_total_count' do
    let!(:model_count) { 28 }
    let!(:dummy_models) { create_list(:dummy_model, model_count) }
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

    context 'with total_count param' do
      before do
        get :index_total_count
      end

      include_examples 'total count pagination param'

      it 'responds with valid page' do
        expect(response_body(response)['page']).to eq expected_list
      end
    end
  end

  describe '#index_scoped_total_count' do
    let!(:model_count) { 28 }
    let!(:dummy_models) { create_list(:dummy_model, model_count) }
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

    context 'with total_count param' do
      before do
        get :index_scoped_total_count
      end

      include_examples 'total count pagination param'

      it 'responds with valid page' do
        expect(response_body(response)['page']).to eq expected_list
      end
    end
  end
end
