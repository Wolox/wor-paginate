require 'spec_helper'

describe Wor::Paginate::Adapters::Enumerable do
  describe '#paginated_content' do
    subject(:paginated_content) { described_class.new(content, page, limit).paginated_content }

    context 'when asks for page 3 of a 9-item enumerable' do
      let(:page) { 3 }
      let(:limit) { 5 }
      let(:content) { (1..9).to_enum }

      it { expect(paginated_content).to be_empty }
    end
  end
end