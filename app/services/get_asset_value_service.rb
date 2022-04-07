class GetAssetValueService
  attr_reader :value
  def initialize(asset, source_index)
    @value = scrape_asset_value(asset, source_index)
  end

  def scrape_asset_value(asset, source_index)
    begin
      doc = Nokogiri::HTML(URI.open(ASSET_SOURCES[source_index]+asset))
    rescue
      raise 'Access error'
    else
      return to_cents(find_value_in_page(doc, source_index).text.strip.gsub(',', '.').to_f)
    end
  end

  private
  ASSET_SOURCES = ['https://statusinvest.com.br/acoes/', 'https://www.infomoney.com.br/', 'https://investnews.com.br/cotacao/']

  def find_value_in_page(doc, source_index)
    case source_index
    when 0
      return doc.css('.special strong')
    when 1
      return doc.css('.line-info .value p')
    when 2
      return doc.css('.acao-valor')
    else
      return false
    end
  end

  def to_cents(value)
    value*100
  end
end
