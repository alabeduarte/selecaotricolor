require "spec_helper"

module CalendarHelpers
  
  def init_oldest_match(home, away)
    Calendar.create!(
                      day: Time.utc(2000, 1, 1, 16, 0), 
                      home: home, 
                      away: away, 
                      contains_formations: false)
  end
  
  def init_last_match(home, away)
    Calendar.create!(
                      day: Time.utc(2000, 1, 1, 17, 0), 
                      home: home, 
                      away: away, 
                      contains_formations: false)
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
      @next_match.id.should == Calendar.next_match.id
    end
    it "find last match" do
      @last_match.id.should_not == @oldest_match.id
      @last_match.id.should == Calendar.last_match.id
    end
  end
end