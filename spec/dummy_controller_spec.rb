# frozen_string_literal: true
require 'spec_helper'
RSpec.describe DummiesController, type: :controller do
  describe '#generate' do
    context 'when dummying the dummy' do
      it 'responds' do
        DummyModel.create(name: 'hola', something: 1)
        byebug
        get :index
      end
    end
  end
end
