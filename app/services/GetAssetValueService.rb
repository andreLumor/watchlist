class GetAssetValue
  attr_reader :value
  def initialize(asset, source_index)
    @value = scrape_asset_value(asset, source_index)
  end

  private
  ASSET_SOURCES = ['https://statusinvest.com.br/acoes/', 'https://www.infomoney.com.br/', 'https://investnews.com.br/cotacao/']

  def scrape_asset_value(asset, source_index)
    begin
      doc = Nokogiri::HTML(URI.open(ASSET_SOURCES[source_index]+asset))
    rescue
      return false
    else
      return find_value_in_page(doc, source_index)
    end
  end

  def find_value_in_page(doc, source_index)
    case source_index
    when 0
      return doc.css('.special strong').text
    when 1
      return doc.css('.line-info .value p').text
    when 2
      return doc.css('.acao-valor').text.strip
    else
      return false
    end
  end
end
