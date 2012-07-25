require 'nokogiri'
require 'open-uri'

class WebReader
  
  attr_reader :title, :selector, :url
  
  def initialize(url)
    @url = url
    @selector = Nokogiri::HTML(open(url))
    @title = @selector.at_css("title").text
  end
  
end
