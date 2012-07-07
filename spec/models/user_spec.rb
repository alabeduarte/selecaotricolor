require 'spec_helper'
require "models/formation/helper"

describe User do
  let(:user_t1) { Factory(:user_t1) }
  let(:user_t2) { Factory(:user_t2) }
  
  before(:each) do      
    formation_helper = Formation::Helper.new    
    # => 4-4-2
    #     AC  Júnior
    #     AC  Souza
    #     AC  Morais
    #     MAD Gabriel
    #     MDE Fahel
    #     MDD Lenine
    #     DE  William Matheus
    #     DD  Madson
    #     DC  Titi
    #     DC  Rafael Donato
    #     G Marcelo Lomba
    json = '[ { "formation": {          "player": "4f25cdcbe1af800323000b46"         ,          "x": "0"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f03b5b6e1af8003be000026"         ,          "x": "0"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f04e68ee1af80017c000034"         ,          "x": "2"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f04e6d3e1af80017c0000a7"         ,          "x": "2"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e69be1af80017c000047"         ,          "x": "4"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f25cc85e1af8003230009be"         ,          "x": "4"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25ca54e1af8003230008b5"         ,          "x": "5"         ,          "y": "0"     }  }  ,  { "formation": {          "player": "4f25ca2de1af800323000896"         ,          "x": "5"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e6dde1af80017c0000c4"         ,          "x": "7"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f2efa0ae1af800c040009c4"         ,          "x": "7"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f04e6c3e1af80017c00008c"         ,          "x": "-1"         ,          "y": "-1"     }  }  ]'
    @formation_1 = Formation.new_by(
                          data: JSON.load(json), 
                          owner: user_t1, 
                          match: Calendar.next_match)
                                                 
    # => 4-4-2
    #     AC  Júnior
    #     AC  Souza
    #     AC  Morais
    #     MAD Gabriel
    #     MDE Fahel
    #     MDD Lenine
    #     DE  William Matheus
    #     DD  Madson
    #     DC  Titi
    #     DC  Rafael Donato
    #     G Marcelo Lomba
    json = '[ { "formation": {          "player": "4f25cdcbe1af800323000b46"         ,          "x": "0"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f03b5b6e1af8003be000026"         ,          "x": "0"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f04e68ee1af80017c000034"         ,          "x": "2"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f04e6d3e1af80017c0000a7"         ,          "x": "2"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e69be1af80017c000047"         ,          "x": "4"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f25cc85e1af8003230009be"         ,          "x": "4"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25ca54e1af8003230008b5"         ,          "x": "5"         ,          "y": "0"     }  }  ,  { "formation": {          "player": "4f25ca2de1af800323000896"         ,          "x": "5"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e6dde1af80017c0000c4"         ,          "x": "7"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f2efa0ae1af800c040009c4"         ,          "x": "7"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f04e6c3e1af80017c00008c"         ,          "x": "-1"         ,          "y": "-1"     }  }  ]'
    @formation_2 = Formation.new_by(
                          data: JSON.load(json), 
                          owner: user_t1, 
                          match: Calendar.last_match)
                          
    # => 4-4-2
    #     AC  Júnior
    #     AC  Souza
    #     AC  Morais
    #     MAD Gabriel
    #     MDE Fahel
    #     MDD Lenine
    #     DE  William Matheus
    #     DD  Madson
    #     DC  Titi
    #     DC  Rafael Donato
    #     G Marcelo Lomba
    json = '[ { "formation": {          "player": "4f25cdcbe1af800323000b46"         ,          "x": "0"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f03b5b6e1af8003be000026"         ,          "x": "0"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f04e68ee1af80017c000034"         ,          "x": "2"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f04e6d3e1af80017c0000a7"         ,          "x": "2"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e69be1af80017c000047"         ,          "x": "4"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f25cc85e1af8003230009be"         ,          "x": "4"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25ca54e1af8003230008b5"         ,          "x": "5"         ,          "y": "0"     }  }  ,  { "formation": {          "player": "4f25ca2de1af800323000896"         ,          "x": "5"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e6dde1af80017c0000c4"         ,          "x": "7"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f2efa0ae1af800c040009c4"         ,          "x": "7"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f04e6c3e1af80017c00008c"         ,          "x": "-1"         ,          "y": "-1"     }  }  ]'
    @formation_3 = Formation.new_by(
                          data: JSON.load(json), 
                          owner: user_t2, 
                          match: Calendar.last_match)
                   
    @formation_1.created_at = Time.utc(2012, 1, 18, 20, 30)       
    @formation_1.save
    
    @formation_2.created_at = Time.utc(2012, 1, 10, 18, 00)
    @formation_2.save
    
    @formation_3.created_at = Time.utc(2011, 1, 10, 18, 00)
    @formation_3.save
  end
  
  context "before destroy" do
    it "should destroy all formations" do
      user_id = user_t1.id
      user_t1.destroy
      Formation.all(owner_id: user_id).should be_empty
    end
  end
  
  context "show data" do
    it "should show default image when image is nil" do
      User.new.image.should == "escudos/bahia.png"
      User.new(admin: true).image.should == "selecaoicone.png"
    end
    
    it "should show your own image when it exists" do
      user = User.new image: "profile.jpg"
      user.image.should == "profile.jpg"
      admin_user = User.new(admin: true, image: "profile.jpg")
      admin_user.image.should == "profile.jpg"
    end
  end
  
  context "listing formations of user" do
    it "should show all formations of user" do
      user_t1.formations.size.should == 2
      user_t1.formations.should be_include(@formation_1)
      user_t1.formations.should be_include(@formation_2)
      user_t1.formations.should_not be_include(@formation_3)
    end
    
    it "should show formations of user ordered by match" do
      user_t1.formations[0].should == @formation_1
      user_t1.formations[1].should == @formation_2
    end
    
    it "should identify formation created by the current user" do
      user_t1.should be_owner_of @formation_1
    end
    
    it "should NOT be true when formation don't created by the current user" do
      user_t1.should_not be_owner_of @formation_3
    end
    
    it "should list most recents formations of user" do
      user_t1.most_recent_formations.size.should == 2
    end
  end
end