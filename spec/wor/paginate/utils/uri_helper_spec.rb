require 'spec_helper'
require 'wor/paginate/utils/uri_helper'

describe Wor::Paginate::Utils::UriHelper do
  describe '.replace_query_params' do
    subject(:replace_query_params) { described_class.replace_query_params(uri, new_query) }

    let(:uri) { 'example.com/users?page=1&name=3' }

    context 'without repeated params' do
      let(:new_query) { { age: 21 } }

      it 'returns the expected uri' do
        expect(replace_query_params).to eq 'example.com/users?page=1&name=3&age=21'
      end
    end

    context 'when repeating params' do
      let(:new_query) { { age: 21, page: 2 } }

      it 'returns the expected uri' do
        expect(replace_query_params).to eq 'example.com/users?page=2&name=3&age=21'
      end
    end
  end
end
