require "spec_helper"
require "models/formation/helper"

describe FirstTeam do 
  
  let(:first_team) { mock_model(FirstTeam).as_null_object }
  let(:scorer) { mock(:scorer).as_null_object }
  let(:formation) { mock_model(Formation).as_null_object }
  let(:new_first_team) { FirstTeam.new(formation: formation) }
  let(:current_user) { Factory(:admin) }

  before(:each) do      
    Formation::Helper.new     
    @json_442 = '[ { "formation": {          "player": "4f03b5b6e1af8003be000026"         ,          "x": "0"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f25cdcbe1af800323000b46"         ,          "x": "1"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f2fd315b3e30f0001000a07"         ,          "x": "2"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f04e6d3e1af80017c0000a7"         ,          "x": "2"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e6b5e1af80017c000073"         ,          "x": "4"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f25cc85e1af8003230009be"         ,          "x": "4"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25ca54e1af8003230008b5"         ,          "x": "6"         ,          "y": "0"     }  }  ,  { "formation": {          "player": "4f25ca2de1af800323000896"         ,          "x": "6"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e6dde1af80017c0000c4"         ,          "x": "7"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f2efa0ae1af800c040009c4"         ,          "x": "7"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25c920e1af800323000879"         ,          "x": "-1"         ,          "y": "-1"     }  }  ]'      
  end
  
  describe "scoring players" do
    it "should make reference with scorer before apply scores" do
      scorer.should_receive(:first_team=).with(new_first_team)
      new_first_team.apply_score(scorer)
    end
    
    it "should add bonus score to all users who create a squad" do      
      new_first_team.should_receive(:apply_score_to_all_users)
      new_first_team.apply_score(scorer)
    end

    it "should score all users must predict the squad" do
      new_first_team.should_receive(:apply_score_to_predict_users)
      new_first_team.apply_score(scorer)
    end
    
    it "should associate new formation when first team w'll created" do
      new_first_team.formation.should_not be_nil
    end
    
  end
  
  describe "showing the last round" do
    it "when the official team has never been created then the first team the last round should be null" do
      FirstTeam.last_of_the_round.should be_nil
    end
    
    it "should load the first team of the last round while the current match has not been started" do
      first_team = FirstTeam.new(formation: new_formation)
      first_team.save
      FirstTeam.last_of_the_round.id.should == first_team.id
    end
    
    it "should load a new first team when a new was created" do
      old_first_team = FirstTeam.new(formation: new_formation(@json_442, Calendar.last_match))
      old_first_team.save
      FirstTeam.last_of_the_round.id.should == old_first_team.id
      
      new_first_team = FirstTeam.new(formation: new_formation)
      new_first_team.save
      FirstTeam.last_of_the_round.id.should == new_first_team.id
    end
  end
  
  describe "showing through match" do
    it "should show by match" do
      new_first_team = FirstTeam.new(formation: new_formation)
      new_first_team.save
      new_first_team.match.should == "Bahia x Vit\u00f3ria"
    end
    
    it "should sorting by match" do
      FirstTeam.new(formation: new_formation(@json_442, Calendar.last_match)).save
      FirstTeam.new(formation: new_formation).save
      tactics = FirstTeam.all_by_match
      tactics.size.should == 2
      tactics[0].match.should == Calendar.next_match.to_s
      tactics[1].match.should == Calendar.last_match.to_s
    end
  end
  
  describe "showing substitutions" do
    before do
      @formation = new_formation(@json_442, Calendar.last_match)
      @first_team = FirstTeam.new(formation: new_formation(@json_442, Calendar.last_match))      
    end
    
    context "when there is substitution" do
      context "and current player has replaced" do
        before do
          @first_team.substitutions << get_substitution(@formation.players_positions[0].player)
        end
        it "should be true" do
          position = @formation.players_positions[0]
          @first_team.has_replaced?(position.player).should be_true
        end
        it "should display the alternate player" do
          position = @formation.players_positions[0]
          @first_team.alternate_of(position.player).name.should == "Alternate player"
        end
      end
      
      context "and current player hasn't replaced" do
        before do
          @first_team.substitutions << get_substitution(@formation.players_positions[5].player)
        end
        it "should NOT be true" do
          position = @formation.players_positions[0]
          @first_team.has_replaced?(position.player).should_not be_true
        end
      end
    end
    
    context "when there are no substitution" do
      before do
        @first_team.substitutions = Array.new
      end
      it "should NOT be true" do
        position = @formation.players_positions[0]
        @first_team.has_replaced?(position.player).should_not be_true
      end
    end
    
    def get_substitution(off)
      Substitution.new(off: off, on: Player.new(id: 2, name: "Alternate player", number: 18, team: Team.bahia))
    end
  end
  
private
  def new_formation(json=@json_442, match=Calendar.next_match)
    Formation.new_by(data: JSON.load(json), owner: current_user, match: match)
  end
end