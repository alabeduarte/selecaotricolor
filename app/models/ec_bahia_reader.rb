class EcBahiaReader
  
  def initialize(reader=WebReader.new('http://www.ecbahia.com'))
    @reader = reader
  end
  
  def breaking_news(limit)
    @reader.highlights( css: '#plantao ul li',
                        url: 'a',
                        date: '.data',
                        title: 'a',
                        host: 'http://www.ecbahia.com',
                        limit: limit
                        )
  end
end
