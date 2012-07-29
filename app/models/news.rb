class News
  attr_reader :url, :date, :title, :image
  
  def initialize(args)
    @url = args[:url]
    @date = args[:date]
    @title = args[:title]
    @image = args[:image]
  end
end