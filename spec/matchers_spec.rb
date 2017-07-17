require 'spec_helper'

RSpec.describe DummyModelsController, type: :controller do
  describe '#be_paginated_with' do
    let!(:model_count) { 2 }
    let!(:dummy_models) { create_list(:dummy_model, model_count) }
    let(:expected_list) do
      dummy_models.first(25).map do |dummy|
        { 'id' => dummy.id, 'name' => dummy.name, 'something' => dummy.something }
      end
    end

    before do
      get :index_custom_formatter
    end

    context 'receiving a custom formatter as an argument' do
      it 'checks the json keys matches between the custom formatter and the response' do
        expect(response_body(response)).to be_paginated_with(CustomFormatter)
      end
    end
  end

  describe '#be_paginated_with' do
    let!(:model_count) { 28 }
    let!(:dummy_models) { create_list(:dummy_model, model_count) }
    let(:expected_list) do
      dummy_models.first(25).map do |dummy|
        { 'id' => dummy.id, 'name' => dummy.name, 'something' => dummy.something }
      end
    end

    before do
      get :index
    end

    it 'checks the json keys matches between the default formatter and the response' do
      expect(response_body(response)).to be_paginated
    end
  end
end
