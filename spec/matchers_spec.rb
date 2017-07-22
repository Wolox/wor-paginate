require 'spec_helper'

RSpec.describe DummyModelsController, type: :controller do
  let!(:model_count) { 28 }
  let!(:dummy_models) { create_list(:dummy_model, model_count) }
  let(:expected_list) do
    dummy_models.first(25).map do |dummy|
      { 'id' => dummy.id, 'name' => dummy.name, 'something' => dummy.something }
    end
  end

  describe '#be_paginated' do
    it 'checks that the response keys matches with the default formatter' do
      get :index
      expect(response_body(response)).to be_paginated
    end

    it 'checks that the response is not paginated with the default formatter' do
      get :index_custom_formatter
      expect(response_body(response)).not_to be_paginated
    end
  end

  describe '#be_paginated.with' do
    it 'checks that the response keys matches with the custom formatter' do
      get :index_custom_formatter
      expect(response_body(response)).to be_paginated.with(CustomFormatter)
    end
  end
end
