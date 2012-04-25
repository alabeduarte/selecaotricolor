require "spec_helper"
require "models/formation/helper"

describe Formation do
    let(:current_user) { Factory(:admin) }
  
    before(:each) do      
      Formation::Helper.new      
      @json_442 = '[ { "formation": {          "player": "4f03b5b6e1af8003be000026"         ,          "x": "0"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f25cdcbe1af800323000b46"         ,          "x": "1"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f2fd315b3e30f0001000a07"         ,          "x": "2"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f04e6d3e1af80017c0000a7"         ,          "x": "2"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e6b5e1af80017c000073"         ,          "x": "4"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f25cc85e1af8003230009be"         ,          "x": "4"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25ca54e1af8003230008b5"         ,          "x": "6"         ,          "y": "0"     }  }  ,  { "formation": {          "player": "4f25ca2de1af800323000896"         ,          "x": "6"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e6dde1af80017c0000c4"         ,          "x": "7"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f2efa0ae1af800c040009c4"         ,          "x": "7"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25c920e1af800323000879"         ,          "x": "-1"         ,          "y": "-1"     }  }  ]'      
    end
  
    context "validations" do
      it "requires players to be set" do
        formation = Formation.new
        formation.players_positions.should_not be_nil
      end
      
      it "requires at least 11 players to be set" do                        
        positions = new_formation.players_positions
        positions.size.should == 11
      end       
    end
    
    context "on create" do
      
      it "when formation is added then next match must be updated with the formation contained" do
        next_match = Calendar.next_match
        next_match.contains_formations?.should be_false
        new_formation.save
        Calendar.next_match.contains_formations?.should be_true
      end 
      
      it "when formation is 4 defenders 4 midfield and 2 forwards then the tactical should be 4-4-2" do
        json = '[ { "formation": {          "player": "4f03b5b6e1af8003be000026"         ,          "x": "0"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f25cdcbe1af800323000b46"         ,          "x": "1"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f2fd315b3e30f0001000a07"         ,          "x": "2"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f04e6d3e1af80017c0000a7"         ,          "x": "2"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e6b5e1af80017c000073"         ,          "x": "4"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f25cc85e1af8003230009be"         ,          "x": "4"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25ca54e1af8003230008b5"         ,          "x": "6"         ,          "y": "0"     }  }  ,  { "formation": {          "player": "4f25ca2de1af800323000896"         ,          "x": "6"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e6dde1af80017c0000c4"         ,          "x": "7"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f2efa0ae1af800c040009c4"         ,          "x": "7"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25c920e1af800323000879"         ,          "x": "-1"         ,          "y": "-1"     }  }  ]'
        new_formation(json).tactical.should == "4-4-2"
      end
      
      it "when formation is 5 defenders 3 midfield and 2 forwards then the tactical should be 5-3-2" do
        json = '[ { "formation": {          "player": "4f03b5b6e1af8003be000026"         ,          "x": "0"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f25cdcbe1af800323000b46"         ,          "x": "1"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f25cc9ae1af8003230009e7"         ,          "x": "4"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f04e6b5e1af80017c000073"         ,          "x": "4"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f25cc85e1af8003230009be"         ,          "x": "4"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25ca54e1af8003230008b5"         ,          "x": "6"         ,          "y": "0"     }  }  ,  { "formation": {          "player": "4f25ca2de1af800323000896"         ,          "x": "6"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f25ca68e1af8003230008d6"         ,          "x": "7"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f2efa0ae1af800c040009c4"         ,          "x": "7"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f04e6dde1af80017c0000c4"         ,          "x": "7"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25c920e1af800323000879"         ,          "x": "-1"         ,          "y": "-1"     }  }  ] '
        new_formation(json).tactical.should == "5-3-2"
      end
      
      it "when formation is 4 defenders 3 midfield and 3 forwards then the tactical should be 4-3-3" do
        json = '[ { "formation": {          "player": "4f03b5b6e1af8003be000026"         ,          "x": "0"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f2fd07db3e30f000100041b"         ,          "x": "1"         ,          "y": "0"     }  }  ,  { "formation": {          "player": "4f04e6d3e1af80017c0000a7"         ,          "x": "1"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f2fd315b3e30f0001000a07"         ,          "x": "3"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f04e6b5e1af80017c000073"         ,          "x": "4"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f25cc85e1af8003230009be"         ,          "x": "4"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25ca54e1af8003230008b5"         ,          "x": "6"         ,          "y": "0"     }  }  ,  { "formation": {          "player": "4f25ca2de1af800323000896"         ,          "x": "6"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f2efa0ae1af800c040009c4"         ,          "x": "7"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f04e6dde1af80017c0000c4"         ,          "x": "7"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25c920e1af800323000879"         ,          "x": "-1"         ,          "y": "-1"     }  }  ] '
        new_formation(json).tactical.should == "4-3-3"
      end
      
      it "when formation is 3 defenders 4 midfield and 3 forwards then the tactical should be 3-4-3" do
        json = '[ { "formation": {          "player": "4f25cdcbe1af800323000b46"         ,          "x": "0"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f03b5b6e1af8003be000026"         ,          "x": "0"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f04e6d3e1af80017c0000a7"         ,          "x": "1"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f25cd83e1af800323000aad"         ,          "x": "3"         ,          "y": "0"     }  }  ,  { "formation": {          "player": "4f2fd315b3e30f0001000a07"         ,          "x": "3"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e6b5e1af80017c000073"         ,          "x": "4"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f25cc85e1af8003230009be"         ,          "x": "4"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f2efa0ae1af800c040009c4"         ,          "x": "6"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f25ca68e1af8003230008d6"         ,          "x": "7"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f04e6dde1af80017c0000c4"         ,          "x": "7"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25c920e1af800323000879"         ,          "x": "-1"         ,          "y": "-1"     }  }  ] '
        new_formation(json).tactical.should == "3-4-3"
      end
      
      it "when formation is 3 defenders 5 midfield and 2 forwards then the tactical should be 3-5-2" do
        json = '[ { "formation": {          "player": "4f2fd07db3e30f000100041b"         ,          "x": "0"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f03b5b6e1af8003be000026"         ,          "x": "0"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f2fd315b3e30f0001000a07"         ,          "x": "2"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f4d9dd3d37b5a00030033be"         ,          "x": "3"         ,          "y": "0"     }  }  ,  { "formation": {          "player": "4f04e6d3e1af80017c0000a7"         ,          "x": "3"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e6b5e1af80017c000073"         ,          "x": "4"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f25cc85e1af8003230009be"         ,          "x": "4"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25ca68e1af8003230008d6"         ,          "x": "6"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f2efa0ae1af800c040009c4"         ,          "x": "6"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f04e6dde1af80017c0000c4"         ,          "x": "7"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f25c920e1af800323000879"         ,          "x": "-1"         ,          "y": "-1"     }  }  ] '        
        new_formation(json).tactical.should == "3-5-2"
      end
    end
    
    context "before create" do
      it "should NOT allow the user to create a new tactic when formation is already created by user" do
        new_formation.save   
        expect { new_formation.save }.should raise_error
      end
    end
    
    context "after create" do
      it "should show newly created formation after create" do
        formation = new_formation
        formation.save   
        Formation.newly_created(current_user).should == formation
      end
    end
    
    context "show formation" do
      it "should show all starting 11 players" do
        formation = new_formation
        formation.save        
        players_ids = ["4f03b5b6e1af8003be000026", "4f25cdcbe1af800323000b46", "4f2fd315b3e30f0001000a07", "4f04e6d3e1af80017c0000a7", "4f04e6b5e1af80017c000073", "4f25cc85e1af8003230009be", "4f25ca54e1af8003230008b5", "4f25ca2de1af800323000896", "4f04e6dde1af80017c0000c4", "4f2efa0ae1af800c040009c4", "4f25c920e1af800323000879"]
        Formation.newly_created(current_user).players_ordered_by_positions.each_with_index.map do |pos, index|
          pos.player.id.to_s.should == players_ids[index]
        end
      end
    end
    
    context "check out the next match is today" do
      it "should checked is true" do
        Time.stub(:now).and_return(Time.utc(2012, 1, 1, 16, 0, 0))
        next_match = Calendar.new(day: Time.utc(2012, 1, 1, 16, 0, 0))
        next_match.today?.should be_true
      end

      it "should checked is false" do
        Time.stub(:now).and_return(Time.utc(2012, 1, 2, 16, 0, 0))
        next_match = Calendar.new(day: Time.utc(2012, 1, 1, 16, 0, 0))
        next_match.today?.should be_false
      end
    end
    
    context "block new formations when" do
      context "given the next match start at 16:00 clock when missing two hours to start the game" do        
        it "should block new formations when now are 16:00 clock" do
          Time.stub(:now).and_return(Time.utc(2012, 1, 1, 16, 0, 0))
          Calendar.stub(:next_match).and_return(Calendar.new(day: Time.utc(2012, 1, 1, 16, 0, 0)))
          Formation.time_is_over?(Calendar.next_match).should be_true
        end

        it "should block new formations when and now are 15:00 hours" do
          Time.stub(:now).and_return(Time.utc(2012, 1, 1, 15, 0, 0))
          Calendar.stub(:next_match).and_return(Calendar.new(day: Time.utc(2012, 1, 1, 16, 0, 0)))
          Formation.time_is_over?(Calendar.next_match).should be_true
        end
        
        it "should block new formations when and now are 14:01 hours" do
          Time.stub(:now).and_return(Time.utc(2012, 1, 1, 14, 01, 00))
          Calendar.stub(:next_match).and_return(Calendar.new(day: Time.utc(2012, 1, 1, 16, 0, 0)))
          Formation.time_is_over?(Calendar.next_match).should be_true
        end
        
        it "should block new formations when and now are 14:00:59 hours" do
          Time.stub(:now).and_return(Time.utc(2012, 1, 1, 14, 0, 59))
          Calendar.stub(:next_match).and_return(Calendar.new(day: Time.utc(2012, 1, 1, 16, 0, 0)))
          Formation.time_is_over?(Calendar.next_match).should be_true
        end
        
        it "should block new formations when and now are 14:00 hours" do
          Time.stub(:now).and_return(Time.utc(2012, 1, 1, 14, 0, 0))
          Calendar.stub(:next_match).and_return(Calendar.new(day: Time.utc(2012, 1, 1, 16, 0, 0)))
          Formation.time_is_over?(Calendar.next_match).should be_true
        end
      end
    end
    
    context "accept new formations when" do
      context "given the next match start at 16:00 clock when missing two hours to start the game" do
        it "should NOT block new formations when and now are 13:59:59 hours" do
          Time.stub(:now).and_return(Time.utc(2012, 1, 1, 13, 59, 59))
          Calendar.stub(:next_match).and_return(Calendar.new(day: Time.utc(2012, 1, 1, 16, 0, 0)))
          Formation.time_is_over?(Calendar.next_match).should_not be_true
        end
      
        it "should NOT block new formations when and now are 13:59:00 hours" do
          Time.stub(:now).and_return(Time.utc(2012, 1, 1, 13, 59, 00))
          Calendar.stub(:next_match).and_return(Calendar.new(day: Time.utc(2012, 1, 1, 16, 0, 0)))
          Formation.time_is_over?(Calendar.next_match).should_not be_true
        end
      end
    end
    
private
  def new_formation(json=@json_442)
    Formation.new_by(data: JSON.load(json), owner: current_user)
  end
end