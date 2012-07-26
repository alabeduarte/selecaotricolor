require 'spec_helper'
describe GloboEsporteReader do
  let(:reader) { reader = GloboEsporteReader.new }
  
  it "should fetch news" do
    news = reader.breaking_news(5)
    news.size.should <= 5
    
    news.each do |n|
      p "#{n.title} (#{n.url})"
    end
  end
  
end
