class GloboEsporteReader
  
  def initialize(reader=WebReader.new('http://globoesporte.globo.com/futebol/times/bahia/'))
    @reader = reader
  end
  
  def breaking_news(limit)
    news = Array.new
    @reader.selector.css('#globo-carrossel-passos .globo-carrossel-passo').first(limit).each do |item|
      if (item)
        href = item.css('a').map { |link| link['href'] }
        title = item.css('a').map { |link| link['title'] }
        news << GloboEsporteNews.new(url: href.first, title: title.first)
      end
    end
    news
  end
  
end
