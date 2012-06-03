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
    end
  end
  
  describe "increase rating" do
    context "when the player does not have rating" do
      it "your rating should be 1" do
        player = Player.create(team: Team.bahia, name: "Some Player", number: 10)
        player.increase_rating
        player.rating.should == 1
      end
    end
    
    context "when the player have rating" do
      it "your rating should be increased" do
        player = Player.create(team: Team.bahia, name: "Some Player", number: 10, rating: 4)
        player.rating.should == 4
        player.increase_rating # 4 to 5
        player.increase_rating # 5 to 6
        player.increase_rating # 6 to 7
        player.rating.should == 7
      end
    end
  end
  
  describe "decrease rating" do    
    context "when the player have rating" do
      it "your rating should be decreased" do
        player = Player.create(team: Team.bahia, name: "Some Player", number: 10, rating: 4)
        player.rating.should == 4
        player.decrease_rating # 4 to 3
        player.rating.should == 3
      end
    end
    
    context "when the player does not have rating but value of rating is zero" do
      it "your rating should be 0" do
        player = Player.create(team: Team.bahia, name: "Some Player", number: 10, rating: 0)
        player.decrease_rating
        player.rating.should == 0
      end
    end
    
    context "when the player does not have rating" do
      it "your rating should be 0" do
        player = Player.create(team: Team.bahia, name: "Some Player", number: 10)
        player.decrease_rating
        player.rating.should == 0
      end
    end
  end
end