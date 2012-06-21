require "spec_helper"
require "models/formation/helper"

describe Scorer do

  let(:admin_user) { Factory(:admin) }
  let(:user_t1) { Factory(:user_t1) }
  let(:user_t2) { Factory(:user_t2) }
  let(:user_t3) { Factory(:user_t3) }
  let(:user_t4) { Factory(:user_t4) }
  let(:user_t5) { Factory(:user_t5) }

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
    @first_team = FirstTeam.new(formation: Formation.new_by(
                          data: JSON.load(json), 
                          owner: admin_user,
                          match: Calendar.last_match))

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
    Formation.new_by(
                          data: JSON.load(json), 
                          owner: user_t1,
                          match: Calendar.last_match).save

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
    Formation.new_by(
                          data: JSON.load(json), 
                          owner: user_t2, 
                          match: Calendar.last_match).save
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
    Formation.new_by(
                          data: JSON.load(json), 
                          owner: user_t3, 
                          match: Calendar.last_match).save
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
    Formation.new_by(
                          data: JSON.load(json), 
                          owner: user_t4, 
                          match: Calendar.last_match).save
                           
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
    Formation.new_by(
                      data: JSON.load(json), 
                      owner: user_t5, 
                      match: Calendar.last_match).save
                          
    @scorer = Scorer.new(match: Calendar.last_match, first_team: @first_team)
    
    # Clean all scores
    clean_scores
  end

  describe "scoring players" do

    it "should add score for the first time" do
      tipsters = Array.new
      new_user = User.create(nickname: 'T1', email: 'teste1@t.com', password: 'mmmmmm', confirmed_at: Time.now.utc)
      tipsters << new_user
      @scorer.add(score: 100, to: tipsters)
      new_user.score.should == 100
    end
    
    it "should score all users who create a squad" do
        tipsters = @first_team.tipsters
        tipsters.size.should == 5
    end
    
    it "should score all users must predict the squad" do
      winners = @first_team.squad_winners
      winners.size.should == 2
    end
    
    it "should add bonus score to all users who create a squad" do
      tipsters = @first_team.tipsters
      tipsters.each {|w| w.should_receive(:score=).with(100)}
      tipsters.each {|w| w.should_receive(:save)} 
      @scorer.add(score: 100, to: tipsters)
    end
    
    it "should list users scores sorted by score" do
      add_score_to_users(@scorer)
      users = User.all_by_score
      users.size.should == 5
      users[0].score.should be >= users[1].score
      users[1].score.should be >= users[2].score
      users[2].score.should be >= users[3].score
      users[3].score.should be >= users[4].score
    end
    
    it "should show the best users scores" do
      add_score_to_users(@scorer)
      users = User.top_scorers_of 3
      users.size.should == 3
      users[0].score.should be >= users[1].score
      users[1].score.should be >= users[2].score
    end
    
    it "should add 170 points to users who predict 7 players" do
      @first_team.apply_score(@scorer)
      User.find_by_email("teste3@t.com").score.should == 70
    end
    
    it "should add 190 points to users who predict 9 players" do
      @first_team.apply_score(@scorer)
      User.find_by_email("teste4@t.com").score.should == 90
    end
    
    it "should add 200 points to users who predict 10 players" do
      @first_team.apply_score(@scorer)
      User.find_by_email("teste5@t.com").score.should == 100
    end
    
    it "should add 150 points to users who predict all players" do
      @first_team.apply_score(@scorer)
      User.find_by_email("teste1@t.com").score.should == 150
      User.find_by_email("teste2@t.com").score.should == 150
    end
    
    it "should show all user must predict the squad" do
      @first_team.apply_score(@scorer)
      tipsters = Array.new
      tipsters << user_t1
      tipsters << user_t2
      @first_team.squad_winners.should == tipsters
    end
  end

private
  def add_score_to_users(scorer)
    all_users = Array.new
    User.all.each {|u| all_users << u unless u.admin?}
    scorer.add(score: 100, to: all_users)
    all_users[0].score = 250
    all_users[0].save
    
    all_users[1].score = 200
    all_users[1].save
    
    all_users[2].score = 190
    all_users[2].save
    
    all_users[3].score = 180
    all_users[3].save
    
    all_users[4].score = 170
    all_users[4].save
  end
  
  def clean_scores
    User.all.each do |u|
      u.score = 0
      u.save
    end
  end
end