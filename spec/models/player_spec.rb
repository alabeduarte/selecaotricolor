require 'spec_helper'
describe Player do
  let(:souza) { Factory(:souza) }
  let(:neto_baiano) { Factory(:neto_baiano) }
  
  before(:all) do
    @bahia = souza.team
  end
  
  context "listing" do
    it "should listing all players of bahia" do
      bahia_squad = Player.players_of(Team.bahia)
      bahia_squad.size.should == 1
      bahia_squad[0].should == souza      
    end
  end
end