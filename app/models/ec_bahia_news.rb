class EcBahiaNews
  attr_reader :url, :date, :title
  
  def initialize(args)
    @url = args[:url]
    @date = args[:date]
    @title = args[:title]
  end
end