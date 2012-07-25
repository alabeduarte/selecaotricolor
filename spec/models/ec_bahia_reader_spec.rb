require 'spec_helper'
describe EcBahiaReader do
  let(:reader) { reader = EcBahiaReader.new }
  
  it "should fetch news" do
    news = reader.breaking_news(5)
    news.size.should == 5
    
    news.each do |n|
      p "#{n.date} - #{n.title} (#{n.url})"
    end
  end
  
end
