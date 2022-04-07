class QuoteJob
  include Sidekiq::Job
  sidekiq_options retry: 5

  def perform(ticker, source_index = rand(3))
    if asset_value = GetAssetValueService.new(ticker, source_index).value
      Asset.find_by(symbol: ticker).quotes.create!(price: asset_value)
    else
      raise 'Asset value could not be found'
    end
  end
end