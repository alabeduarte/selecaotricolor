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
  
  describe "notificating after rating" do
    let(:player) { Player.new(name: "Some Player") }
    let(:mail_message) { mock(:mail_message).as_null_object}
    
    before do      
      FormationMailer.stub(:player_has_been_assessed).and_return(mail_message)
    end
    
    it "should send notification for admin user after rating increase" do
      should_send_notification_with(player)
      player.increase_rating
    end
    
    it "should send notification for admin user after rating decrease" do
      should_send_notification_with(player)
      player.decrease_rating      
    end
    
    def should_send_notification_with(player)      
      FormationMailer.should_receive(:player_has_been_assessed).with(player)
      mail_message.should_receive(:deliver)
    end
  end
  
  describe "linkfiy avatar of players" do
    it "should linkify Lulinha" do
      player = Player.new name: "Lulinha"
      player.avatar.should == "lulinha.jpg"
    end
    
    it "should linkify H\u00e9lder" do
      player = Player.new name: "H\u00e9lder"
      player.avatar.should == "helder.jpg"
    end
    
    it "should linkify \u00C1vine" do
      player = Player.new name: "\u00C1vine"
      player.avatar.should == "avine.jpg"
    end
    
    it "should linkify Marcelo Lomba" do
      player = Player.new name: "Marcelo Lomba"
      player.avatar.should == "marcelolomba.jpg"
    end
  end
end