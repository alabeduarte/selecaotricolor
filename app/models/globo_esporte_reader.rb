class GloboEsporteReader
  
  def initialize(reader=WebReader.new('http://globoesporte.globo.com/futebol/times/bahia/'))
    @reader = reader
  end
  
  def breaking_news(limit)
    news = Array.new
    urls = fetch(limit: limit, css: '#globo-carrossel-passos .globo-carrossel-passo', tag: 'a', property: 'href')
    titles = fetch(limit: limit, css: '#globo_destaque_carrossel ul li', tag: 'a')
    images = fetch(limit: limit, css: '#globo-carrossel-thumbs div.globo-carrossel-thumb-content', tag: 'img', property: 'src')
    urls.size.times do |index|
      news << GloboEsporteNews.new(url: urls[index], title: titles[index], image: images[index])
    end
    news
  end
  
private
  def fetch(args)
    array = Array.new
    @reader.selector.css(args[:css]).first(args[:limit]).each do |item|
      if (item)
        if (args[:property].nil?)
          array << item.css(args[:tag]).text
        else
          array << item.css(args[:tag]).map { |doc| doc[args[:property]] }.first
        end
      end
    end
    array
  end
  
end
