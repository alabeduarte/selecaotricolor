require "spec_helper"
require "models/formation/helper"

describe Scorer do

  let(:admin_user) { Factory(:admin) }
  let(:user_t1) { Factory(:user_t1) }
  let(:user_t2) { Factory(:user_t2) }
  let(:user_t3) { Factory(:user_t3) }

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
    @first_team = FirstTeam.create_from(
                          data: JSON.load(json), 
                          owner: admin_user, 
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
    Formation.create_from(
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
    Formation.create_from(
                          data: JSON.load(json), 
                          owner: user_t2, 
                          match: Calendar.last_match)
    # => 3-4-3
    #     AC  Júnior
    #     AC  Souza
    #     AC  Ciro
    #     MAE Magno
    #     MAD Gabriel
    #     ME  Morais
    #     MD  Lulinha
    #     DC  Fahel
    #     DC  Titi
    #     DC  Rafael Donato
    #     G Omar
    json = '[ { "formation": {          "player": "4f25cdcbe1af800323000b46"         ,          "x": "0"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f03b5b6e1af8003be000026"         ,          "x": "0"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f2fd07db3e30f000100041b"         ,          "x": "0"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f2fd315b3e30f0001000a07"         ,          "x": "2"         ,          "y": "0"     }  }  ,  { "formation": {          "player": "4f04e6d3e1af80017c0000a7"         ,          "x": "2"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e68ee1af80017c000034"         ,          "x": "3"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f03baa6e1af8003ee00000f"         ,          "x": "3"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f04e69be1af80017c000047"         ,          "x": "6"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f04e6dde1af80017c0000c4"         ,          "x": "7"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f2efa0ae1af800c040009c4"         ,          "x": "7"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25c920e1af800323000879"         ,          "x": "-1"         ,          "y": "-1"     }  }  ]'
    Formation.create_from(
                          data: JSON.load(json), 
                          owner: user_t3, 
                          match: Calendar.last_match)
    # => 3-4-3                                              
    #     AC  Souza
    #     AC  Júnior
    #     AC  Gabriel
    #     ME  Ávine
    #     MD  Lulinha
    #     MDE Morais
    #     MDD Lenine
    #     DC  Fahel
    #     DC  Titi
    #     DC  Rafael Donato
    #     G Marcelo Lomba
    json = '[ { "formation": {          "player": "4f03b5b6e1af8003be000026"         ,          "x": "0"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f25cdcbe1af800323000b46"         ,          "x": "1"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f04e6d3e1af80017c0000a7"         ,          "x": "1"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f26088ce1af8009550001dd"         ,          "x": "3"         ,          "y": "0"     }  }  ,  { "formation": {          "player": "4f03baa6e1af8003ee00000f"         ,          "x": "3"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e68ee1af80017c000034"         ,          "x": "4"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f25cc85e1af8003230009be"         ,          "x": "4"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f04e69be1af80017c000047"         ,          "x": "6"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f04e6dde1af80017c0000c4"         ,          "x": "7"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f2efa0ae1af800c040009c4"         ,          "x": "7"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f04e6c3e1af80017c00008c"         ,          "x": "-1"         ,          "y": "-1"     }  }  ]'
    Formation.create_from(
                          data: JSON.load(json), 
                          owner: user_t1, 
                          match: Calendar.last_match)
                           
    # => 4-4-2
    #     AC  Júnior
    #     AC  Souza
    #     MAC Morais
    #     MAD Gabriel
    #     MDE Fahel
    #     MDD Lenine
    #     DE  Ávine
    #     DD  Madson
    #     DC  Titi
    #     DC  Rafael Donato
    #     G Marcelo Lomba                                              
    json = '[ { "formation": {          "player": "4f25cdcbe1af800323000b46"         ,          "x": "0"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f03b5b6e1af8003be000026"         ,          "x": "0"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f04e68ee1af80017c000034"         ,          "x": "2"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f04e6d3e1af80017c0000a7"         ,          "x": "2"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f04e69be1af80017c000047"         ,          "x": "4"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f25cc85e1af8003230009be"         ,          "x": "4"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f26088ce1af8009550001dd"         ,          "x": "6"         ,          "y": "0"     }  }  ,  { "formation": {          "player": "4f25ca2de1af800323000896"         ,          "x": "6"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e6dde1af80017c0000c4"         ,          "x": "7"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f2efa0ae1af800c040009c4"         ,          "x": "7"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f04e6c3e1af80017c00008c"         ,          "x": "-1"         ,          "y": "-1"     }  }  ]'
    Formation.create_from(
                          data: JSON.load(json), 
                          owner: user_t3, 
                          match: Calendar.last_match)                                                
  end
  
  context "scoring players" do
    it "should elect the most votes tactical formation by matches" do
      Calendar.last_match.tactical_most_voted.should == '4-4-2'
    end
    
    it "should score all users who create a squad" do             
        scorer = Scorer.new(match: Calendar.last_match)
        winners = scorer.winners
        winners.size.should == 3
    end
    
    it "should score all users must predict the squad" do
      scorer = Scorer.new(match: Calendar.last_match, first_team: @first_team)
      winners = scorer.squad_winners
      winners.size.should == 2
    end
    
    it "should add bonus score to all users who create a squad" do
      scorer = Scorer.new(match: Calendar.last_match)
      winners = scorer.winners
      winners.each {|w| w.should_receive(:score=).with(100)}
      winners.each {|w| w.should_receive(:save)} 
      scorer.add(score: 100, to: winners)      
    end
    
    xit "should elect the most votes players positions by formations of matches"
  end
end