require "spec_helper"

module CalendarHelpers
  
  def init_oldest_match(home, away)
    Calendar.create!(
                      day: Time.utc(2000, 1, 1, 16, 0), 
                      home: home, 
                      away: away, 
                      contains_formations: true)
  end
  
  def init_last_match(home, away)
    Calendar.create!(
                      day: Time.utc(2000, 1, 1, 17, 0), 
                      home: home, 
                      away: away, 
                      contains_formations: true)
  end
  
  def init_next_match(home, away)
    Calendar.create!(
                      day: Time.utc(3000, 1, 1, 17, 0), 
                      home: home, 
                      away: away, 
                      contains_formations: false)
  end
  
end

describe Calendar do
  include CalendarHelpers
  
  before(:each) do
    bahia = Factory(:bahia)
    vitoria = Factory(:vitoria)
    @oldest_match = init_oldest_match(bahia, vitoria)
    @last_match = init_last_match(bahia, vitoria)
    @next_match = init_next_match(bahia, vitoria)
  end
  
  context "find matches" do
    it "find next match" do
      @next_match.next?.should be_true
    end
    it "find last match" do
      @last_match.id.should_not == @oldest_match.id
      @last_match.last?.should be_true
    end    
    it "find oldest match" do
      @oldest_match.oldest?.should be_true
      @last_match.oldest?.should be_true
    end
    
    it "list all matches with tactics" do
      matches = Calendar.with_tactics      
      matches.size.should == 2
      matches.at(0).should == @last_match
      matches.at(1).should == @oldest_match
    end
  end
end