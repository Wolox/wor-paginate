require 'support/shared_context/default_pagination_params'
require 'support/shared_examples/proper_pagination_params'
require 'spec_helper'

describe PostsController, type: :request do
  describe '#index' do
    let(:posts) { create_list(:post, 3) }
    let(:new_posts) { create_list(:post, 2) }

    it do
      posts

      get '/posts', params: { per: 2 }

      expect(response_body['page'].pluck('id')).to eq posts.first(2).map(&:id)
      expect(response_body['count']).to eq 2

      new_posts
      next_url = response_body['next_page_url']

      get next_url

      expect(response_body['page'].pluck('id')).to eq posts.last(1).map(&:id)
      expect(response_body['total_count']).to eq 3
      expect(response_body['count']).to eq 1

      get '/posts'

      expect(response_body['total_count']).to eq 5
      expect(response_body['page'].pluck('id')).to eq((posts + new_posts).map(&:id))
    end
  end
end
