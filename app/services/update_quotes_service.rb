class UpdateQuotesService
  def self.enqueue_jobs
    Asset.find_each do |asset|
      QuoteJob.perform_async(asset.symbol)
    end
  end
end
