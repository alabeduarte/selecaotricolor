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
  
  context "scoring players" do
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
  
  context "showing the last round" do
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
  
private
  def new_formation(json=@json_442, match=Calendar.next_match)
    Formation.new_by(data: JSON.load(json), owner: current_user, match: match)
  end
end