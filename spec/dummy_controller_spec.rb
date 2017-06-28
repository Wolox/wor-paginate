# frozen_string_literal: true
require 'spec_helper'
RSpec.describe DummyModelsController, type: :controller do
  describe '#index' do
    context 'when paginating an ActiveModel with no previous pagination' do
      before do
        create_list(:dummy_model, 7)
        get :index
      end

      it 'responds with items' do
        response_json = JSON.parse(response.body)
        expect(response_json['items'].length).to be 5
      end

      it 'responds with count' do
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


    context 'when paginating an ActiveModel paginated with kaminari' do
      before do
        create_list(:dummy_model, 7)
        get :index_kaminari
      end

      it 'responds with items' do
        response_json = JSON.parse(response.body)
        expect(response_json['items'].length).to be 5
      end

      it 'responds with count' do
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

    context 'when paginating an ActiveModel paginated with will_paginate' do
      before do
        create_list(:dummy_model, 7)
        get :index_will_paginate
      end

      it 'responds with items' do
        response_json = JSON.parse(response.body)
        expect(response_json['items'].length).to be 5
      end

      it 'responds with count' do
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


    context 'when paginating an array' do
      before do
        get :index_array
      end

      it 'responds with items' do
        response_json = JSON.parse(response.body)
        expect(response_json['items'].length).to be 5
      end

      it 'responds with count' do
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
