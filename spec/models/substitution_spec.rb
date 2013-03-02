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

    it "should add substitution in list of substitutions of the first team" do
      substitution = add_substitution!
      substitution.id.should_not be_nil
      Substitution.total(@first_team).should == 1
    end

    it "should add 2 substitutions" do
      add_substitution!
      add_substitution!
      Substitution.total(@first_team).should == 2
    end

    it "should add 3 substitutions" do
      add_substitution!
      add_substitution!
      add_substitution!
      Substitution.total(@first_team).should == 3
    end

    it "should not add more than 4 substitutions" do
      add_substitution!
      add_substitution!
      add_substitution!
      expect { add_substitution! }.to raise_error
      Substitution.total(@first_team).should == 3
    end
  end

private
  def new_formation(json=@json_442, match=Calendar.next_match)
    Formation.new_by(data: JSON.load(json), owner: current_user, match: match)
  end

  def add_substitution!
    substitution = get_substitution
    substitution.first_team = @first_team
    substitution.save
    substitution
  end

  def get_substitution
    off = Player.new(id: 1, name: "Off player", number: 10, team: Team.bahia)
    on = Player.new(id: 2, name: "On player", number: 18, team: Team.bahia)
    Substitution.new(off: off, on: on)
  end
end
