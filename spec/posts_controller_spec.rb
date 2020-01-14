require 'support/shared_context/default_pagination_params'
require 'support/shared_examples/proper_pagination_params'
require 'spec_helper'

describe PostsController, type: :request do
  describe '#index' do
    let(:posts) { create_list(:post, 3) }
    let(:new_posts) { create_list(:post, 2) }
    let(:url) { '/posts' }

    include_examples 'infinite scroll'
  end

  describe '#index_by_id' do
    let(:url) { '/posts/index_by_id' }
    let(:posts) { create_list(:post, 3) }
    let(:new_posts) { create_list(:post, 2) }

    include_examples 'infinite scroll'
  end
end
