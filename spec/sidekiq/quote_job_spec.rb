require 'rails_helper'

describe QuoteJob do
  it { is_expected.to be_retryable 5 }

  context '.perform' do
    subject(:job) { described_class.perform_async('PETR3', 1) }
    
    before do
      Sidekiq::Testing.inline!
      Asset.find_or_create_by(symbol: 'PETR3', currency: 'BRL')
    end

    it 'should create a new quote', :vcr do
      expect { job }.to change { Quote.count }.by(1)
    end
  end
end
