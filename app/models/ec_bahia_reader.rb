class EcBahiaReader
  
  def initialize(reader=WebReader.new('http://www.ecbahia.com'))
    @reader = reader
  end
  
  def breaking_news(limit)
    news = Array.new
    @reader.selector.css('#plantao ul li').first(limit).each do |item|
      href = item.css('a').map { |link| link['href'] }
      url = "#{@reader.url}#{href.first}"
      date = item.at_css('.data').text
      title = item.at_css('a').text
      news << EcBahiaNews.new(url: url, date: date, title: title)
    end
    news
  end
  
end
