require 'spec_helper'
describe GloboEsporteReader do
  let(:reader) { reader = GloboEsporteReader.new }

  it "should fetch news" do
    news = reader.breaking_news(4)
    news.should_not be_empty
  end

end
