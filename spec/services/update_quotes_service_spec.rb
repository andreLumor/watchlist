require 'rails_helper'  
require 'sidekiq/testing'

describe UpdateQuotesService do
  before do
    Sidekiq::Testing.fake!
    Asset.find_or_create_by(symbol: 'PETR3', currency: 'BRL')
    Asset.find_or_create_by(symbol: 'ABEV3', currency: 'BRL')
  end
  context '.enqueue_jobs' do
    it "enqueues update quote job of every asset on the database" do
      UpdateQuotesService.enqueue_jobs
      expect(QuoteJob).to have_enqueued_sidekiq_job('PETR3')
      expect(QuoteJob).to have_enqueued_sidekiq_job('ABEV3')
    end
  end
end
