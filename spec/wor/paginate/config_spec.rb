require 'spec_helper'

describe Wor::Paginate::Config, type: :controller do
  context 'with default config' do
    described_class::DEFAULTS_CONFIGS.each do |attribute, value|
      before do
        described_class.reset!
      end

      it 'responds to the attribute' do
        expect(described_class.respond_to?(attribute)).to be_truthy
      end

      it 'has a default' do
        expect(described_class.send(attribute)).to be(value)
      end
    end
  end

  context 'with default adapters' do
    described_class::DEFAULT_ADAPTERS.each do |_, value|
      before { described_class.reset_adapters! }

      it 'has default values' do
        expect(described_class.adapters.include?(value)).to be true
      end
    end
  end

  context 'when clearing adapters' do
    before { described_class.empty_adapters }

    after { described_class.reset_adapters! }

    it 'has empty adapters' do
      expect(described_class.adapters).to be_empty
    end
  end

  context 'when adding and removing adapters' do
    before do
      described_class.remove_adapter(kaminari)
      described_class.remove_adapter(will_paginate)
      described_class.add_adapter(CustomAdapter)
    end

    let(:kaminari) { described_class::DEFAULT_ADAPTERS[:kaminari] }
    let(:will_paginate) { described_class::DEFAULT_ADAPTERS[:will_paginate] }

    after { described_class.reset_adapters! }

    it 'has empty adapters' do
      expect(described_class.adapters.include?(kaminari)).to be false
      expect(described_class.adapters.include?(will_paginate)).to be false
      expect(described_class.adapters.include?(CustomAdapter)).to be true
    end
  end

  described_class::DEFAULTS_CONFIGS.except(:default_adapter).each do |attribute, _value|
    context "changing #{attribute}" do
      let!(:n) { rand(300) }

      before do
        described_class.reset!
        Wor::Paginate.configure { |c| c.send("#{attribute}=", n) }
      end

      it 'changes to the applied value' do
        expect(described_class.send(attribute)).to be(n)
      end
    end
  end
end
