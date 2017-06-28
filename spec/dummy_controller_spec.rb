# frozen_string_literal: true
require 'spec_helper'
RSpec.describe DummyModelsController, type: :controller do
  describe '#generate' do
    context 'when dummying the dummy' do
      before do
        DummyModel.delete_all # use db cleaner
        # use factory girl for these:
        DummyModel.create(name: 'hola', something: 1)
        DummyModel.create(name: 'hola2', something: 2)
        DummyModel.create(name: 'hola3', something: 3)
        DummyModel.create(name: 'hola4', something: 2)
        DummyModel.create(name: 'hola5', something: 3)
        DummyModel.create(name: 'hola6', something: 2)
        DummyModel.create(name: 'hola7', something: 3)
        get :index
      end

      it 'responds with items' do
      response_json = JSON.parse(response.body)
        expect(response_json['items'].length).to be 5
      end

      it 'responds with count' do
        byebug
        response_json = JSON.parse(response.body)
        expect(response_json['count']).to be 5
      end

      it 'responds with total_count' do
        response_json = JSON.parse(response.body)
        expect(response_json['total']).to be 7
      end

      it 'responds with page' do
        response_json = JSON.parse(response.body)
        expect(response_json['page']).to be 0
      end
    end
  end
end
