class GloboEsporteReader
  
  def initialize(reader=WebReader.new('http://globoesporte.globo.com/futebol/times/bahia/'))
    @reader = reader
  end
  
  def breaking_news(limit)
    news = Array.new
    urls = fetch(limit, '#globo-carrossel-passos .globo-carrossel-passo', 'a', 'href')
    titles = fetch(limit, '#globo_destaque_carrossel ul li', 'a')
    images = fetch(limit, '#globo-carrossel-thumbs div.globo-carrossel-thumb-content', 'img', 'src')
    urls.size.times do |index|
      news << GloboEsporteNews.new(url: urls[index], title: titles[index], image: images[index])
    end
    news
  end
  
private
  def fetch(limit, css, tag, *options)
    array = Array.new
    @reader.selector.css(css).first(limit).each do |item|
      if (item)
        if (options.empty?)
          array << item.css(tag).text
        else
          array << item.css(tag).map { |doc| doc[options.first] }.first
        end
      end
    end
    array
  end
  
end
