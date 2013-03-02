require 'spec_helper'

describe RssReader do
  let(:globoesporte) { globoesporte = RssReader.new('http://globoesporte.globo.com/dynamo/futebol/times/bahia/rss2.xml') }

  it "title should be nil when rss is not valid" do
    RssReader.new('rss-fail').title.should be_nil
  end

  context "fetching title" do
    it "should fetch globoesporte title" do
      globoesporte.title.should == 'bahia'
    end
  end

  context "fetching url" do
    it "should fetch globoesporte url" do
      globoesporte.url.should == 'http://globoesporte.globo.com'
    end
  end

  context "fetching entries" do
    it "should fecth globoesporte entries" do
      entry = globoesporte.entries.first
      entry.title.should_not be_nil
      entry.url.should_not be_nil
      entry.summary.should_not be_nil
    end
  end

end
