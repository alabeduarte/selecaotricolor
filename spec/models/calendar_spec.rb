require "spec_helper"
require "models/calendar/helper"
describe Calendar do
  before(:each) do
    calendar_helper = Calendar::Helper.new
    
    @bahia = Factory(:bahia)
    @vitoria = Factory(:vitoria)
    @oldest_match = calendar_helper.init_oldest_match(@bahia, @vitoria)
    @last_match = calendar_helper.init_last_match(@bahia, @vitoria)
    @next_match = calendar_helper.init_next_match(@bahia, @vitoria)
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
    
    it "should show description thought to string match" do
      Calendar.next_match.to_s.should == "#{@bahia.name} x #{@vitoria.name}"
    end
  end
  
  context "before destroy" do
    it "should destroy all formations" do
      Formation.create(owner: Factory(:user), match: Calendar.next_match, created_at: Time.now, team: @bahia)
      match = Calendar.next_match
      match_id = match.id
      match.destroy
      Formation.all(match_id: match_id).should be_empty
    end
  end
  
end