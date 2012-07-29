require 'nokogiri'
require 'open-uri'

class WebReader
  
  attr_reader :title, :selector, :url
  
  def initialize(url)
    @url = url
    @selector = Nokogiri::HTML(open(url))
    @title = @selector.at_css("title").text
  end
  
  def highlights(args)
    news = Array.new
    @selector.css(args[:css]).first(args[:limit]).each do |item|
      if (item)
        url = item.css(args[:url]).map { |doc| doc['href'] }.first if args[:url]
        date = item.css(args[:date]).text if args[:date]
        title = item.css(args[:title]).text if args[:title]
        image = item.css(args[:image]).map { |doc| doc['src'] }.first if args[:image]
        if (args[:host])
          host = args[:host]
          url = "#{host}/#{url}".gsub('../', '').gsub('//', '/') if url
          image = "#{host}/#{image}".gsub('../', '').gsub('//', '/') if image
        end
        news << News.new(url: url, date: date, title: title, image: image)
      end
    end
    news
  end
  
end
