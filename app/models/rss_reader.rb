require 'feedzirra'
class RssReader
  attr_reader :title, :url, :last_modified
  
  def initialize(url)
    @feed = Feedzirra::Feed.fetch_and_parse(url)
    if valid?
      @title = @feed.title
      @url = @feed.url
    end
  end
  
  def entries
    @feed.entries
  end
  
private
  def valid?
    @feed != 0
  end
end
