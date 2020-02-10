require 'spec_helper'
require 'wor/paginate/utils/uri_helper'
require 'wor/paginate/utils/preserve_records_helper'

describe Wor::Paginate::Utils::PreserveRecordsHelper do
  describe '#call' do
    subject(:call) { described_class.new(Post.all, url, options).call }

    let(:url) { "example.com/dummies#{query_params}" }
    let(:content) { create_list(:post, 3) }
    let(:query_params) { '' }

    before { freeze_time }
    after { travel_back }

    context 'with default options' do
      let(:options) { {} }

      context 'without query params' do
        before do
          content
          call
        end

        it 'sets expected query param' do
          expect(Wor::Paginate::Utils::UriHelper.query_params(call.second))
            .to include('created_at_let' => Time.zone.now.iso8601(10))
        end

        it 'returns the expected content' do
          expect(call.first.ids).to match_array(content.map(&:id))
        end
      end

      context 'with query params' do
        let(:requested_time) { Time.zone.now + 1.minutes }
        let(:query_params) { "?created_at_let=#{requested_time}" }
        let(:new_content) { create_list(:post, 3, created_at: requested_time + 2.minutes) }

        before do
          content
          new_content
          call
        end

        it 'preserves query param' do
          expect(Wor::Paginate::Utils::UriHelper.query_params(call.second)['created_at_let'].to_s)
            .to eq requested_time.to_s
        end

        it 'returns the expected content' do
          expect(call.first.ids).to match_array(content.map(&:id))
        end
      end

      context 'when using field option' do
        let(:options) { { field: :updated_at } }
        let(:requested_time) { Time.zone.now + 1.minutes }
        let(:query_params) { "?updated_at_let=#{requested_time}" }
        let(:new_content) { create_list(:post, 3, updated_at: requested_time + 2.minutes) }

        before do
          content
          new_content
          call
        end

        it 'preserves query param' do
          expect(Wor::Paginate::Utils::UriHelper.query_params(call.second)['updated_at_let'].to_s)
            .to eq requested_time.to_s
        end

        it 'returns the expected content' do
          expect(call.first.ids).to match_array(content.map(&:id))
        end
      end
    end

    context 'when preserving by id' do
      let(:options) { { by: :id } }

      before do
        content
        call
      end

      context 'without query params' do
        it 'sets expected query param' do
          expect(Wor::Paginate::Utils::UriHelper.query_params(call.second)['id_let'].to_i)
            .to eq content.last.id
        end

        it 'returns the expected content' do
          expect(call.first.ids).to match_array(content.map(&:id))
        end
      end

      context 'with query params' do
        let(:requested_id) { content.second.id }
        let(:query_params) { "?id_let=#{requested_id}" }

        it 'returns the expected content' do
          expect(call.first.ids).to match_array(content.first(2).map(&:id))
        end
      end
    end

    context 'with invalid options' do
      let(:options) { { by: :alala } }

      it 'raises ArgumentError' do
        expect { call }.to raise_error(ArgumentError)
      end
    end
  end
end
