require 'spec_helper'
describe EcBahiaReader do
  let(:reader) { reader = EcBahiaReader.new }

  it "should fetch news" do
    news = reader.breaking_news(5)
    news.should_not be_empty
  end

end
