require "spec_helper"
require "models/formation/helper"
  describe FirstTeamsController do
    login_admin
    
    before(:each) do      
      Formation::Helper.new      
      @json = '[ { "formation": {          "player": "4f03b5b6e1af8003be000026"         ,          "x": "0"         ,          "y": "2"     }  }  ,  { "formation": {          "player": "4f25cdcbe1af800323000b46"         ,          "x": "1"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f2fd315b3e30f0001000a07"         ,          "x": "2"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f04e6d3e1af80017c0000a7"         ,          "x": "2"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e6b5e1af80017c000073"         ,          "x": "4"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f25cc85e1af8003230009be"         ,          "x": "4"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25ca54e1af8003230008b5"         ,          "x": "6"         ,          "y": "0"     }  }  ,  { "formation": {          "player": "4f25ca2de1af800323000896"         ,          "x": "6"         ,          "y": "4"     }  }  ,  { "formation": {          "player": "4f04e6dde1af80017c0000c4"         ,          "x": "7"         ,          "y": "1"     }  }  ,  { "formation": {          "player": "4f2efa0ae1af800c040009c4"         ,          "x": "7"         ,          "y": "3"     }  }  ,  { "formation": {          "player": "4f25c920e1af800323000879"         ,          "x": "-1"         ,          "y": "-1"     }  }  ]'      
    end
    
    describe "POST 'create'" do
      it "should load all the matches in descending order before creating a tactical formation" do
        Calendar.should_receive(:with_tactics)
        get :new, :link => {:url => "http://localhost:3000/first_teams/new"}
      end

      it "creates first team and redirects to overview" do
        first_team = mock_model(FirstTeam)
        FirstTeam.stub(:create_from).and_return(first_team)
        FirstTeam.should_receive(:create_from).with(anything)
        post :create, :link => {:url => "http://localhost:3000/first_teams"}
      end

      xit "displays all first teams" do
        
      end
    end
end