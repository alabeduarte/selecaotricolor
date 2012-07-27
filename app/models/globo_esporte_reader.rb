class GloboEsporteReader
  
  def initialize(reader=WebReader.new('http://globoesporte.globo.com/futebol/times/bahia/'))
    @reader = reader
  end
  
  def breaking_news(limit)
    news = Array.new
    @reader.selector.css('#globo-carrossel-passos .globo-carrossel-passo').first(limit).each do |item|
      if (item)
        doc = item.css('a').map { |doc| doc['href'] }
        news << GloboEsporteNews.new(url: doc.first)
      end
    end
    
    @reader.selector.css('#globo_destaque_carrossel ul li').first(limit).each do |item|
      if (item)
        doc = item.css('a').text
        news << GloboEsporteNews.new(title: doc)
      end
    end
    
    @reader.selector.css('#globo-carrossel-thumbs div.globo-carrossel-thumb-content').first(limit).each do |item|
      if (item)
        doc = item.css('img').map { |doc| doc['src'] }
        news << GloboEsporteNews.new(image: doc.first)
      end
    end
    news
  end
  
private
  def fetch_url(selector, limit)
    selector.css('#globo-carrossel-passos .globo-carrossel-passo').first(limit).each do |item|
      if (item)
        doc = item.css('a').map { |doc| doc['href'] }
        return doc.first
      end
    end
  end
  
  def fetch_text(selector, limit)
    selector.css('#globo_destaque_carrossel ul li').first(limit).each do |item|
      if (item)
        doc = item.css('a').text
        return doc.first
      end
    end
  end
  
  def fetch_image(selector, limit)
    selector.css('#globo-carrossel-thumbs div.globo-carrossel-thumb-content').first(limit).each do |item|
      if (item)
        doc = item.css('img').map { |doc| doc['src'] }
        return doc.first
      end
    end
  end
  
end
