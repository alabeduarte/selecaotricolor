require 'spec_helper'
require "models/formation/helper"

describe Substitution do
  let(:current_user) { Factory(:admin) }
  
  before(:each) do      
    Formation::Helper.new     
    @json_442 = '[ { "formation": {          "player": "4f03b5b6e1af8003be000026"         ,          "x": "0"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f25cdcbe1af800323000b46"         ,          "x": "1"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f2fd315b3e30f0001000a07"         ,          "x": "2"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f04e6d3e1af80017c0000a7"         ,          "x": "2"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e6b5e1af80017c000073"         ,          "x": "4"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f25cc85e1af8003230009be"         ,          "x": "4"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25ca54e1af8003230008b5"         ,          "x": "6"         ,          "y": "0"     }  }  ,  { "formation": {          "player": "4f25ca2de1af800323000896"         ,          "x": "6"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e6dde1af80017c0000c4"         ,          "x": "7"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f2efa0ae1af800c040009c4"         ,          "x": "7"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25c920e1af800323000879"         ,          "x": "-1"         ,          "y": "-1"     }  }  ]'      
    @first_team = FirstTeam.create(formation: new_formation)
  end
  
  describe "adding substitutions" do
    let(:@first_team) { mock.as_null_object }
    it "should add substitution in list of substitutions of the first team" do      
      substitution = get_substitution
      @first_team.substitutions << substitution
      @first_team.save!
      @first_team_saved = FirstTeam.find(@first_team.id)
      @first_team_saved.substitutions[0].id.should_not be_nil
      @first_team_saved.substitutions[0].should == substitution
    end
    
    it "should add 2 substitutions" do
      @first_team.substitutions << get_substitution
      @first_team.substitutions << get_substitution
      @first_team.valid?.should be_true
    end
    
    it "should add 3 substitutions" do
      @first_team.substitutions << get_substitution
      @first_team.substitutions << get_substitution
      @first_team.substitutions << get_substitution
      @first_team.valid?.should be_true
    end
    
    it "should not add more than 4 substitutions" do
      @first_team.substitutions << get_substitution
      @first_team.substitutions << get_substitution
      @first_team.substitutions << get_substitution
      @first_team.substitutions << get_substitution
      @first_team.valid?.should_not be_true
    end
    
    def get_substitution
      off = Player.new(id: 1, name: "Off player", number: 10, team: Team.bahia)
      on = Player.new(id: 2, name: "On player", number: 18, team: Team.bahia)
      Substitution.new(off: off, on: on)
    end
  end
  
private
  def new_formation(json=@json_442, match=Calendar.next_match)
    Formation.new_by(data: JSON.load(json), owner: current_user, match: match)
  end
end