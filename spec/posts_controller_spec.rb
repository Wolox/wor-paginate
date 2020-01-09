require 'support/shared_context/default_pagination_params'
require 'support/shared_examples/proper_pagination_params'
require 'spec_helper'

describe DummyModelsController, type: :request do
  describe '#index' do
    let(:posts) { create_list(:post, 4) }
    let(:new_posts) { create_list(:post, 2) }

    it do
      posts
      res1 = get '/posts', params: { limit: 2 }
    end
  end
end
