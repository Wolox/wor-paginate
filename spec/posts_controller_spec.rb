require 'support/shared_examples/infinite_scroll'
require 'support/time_helpers'
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
