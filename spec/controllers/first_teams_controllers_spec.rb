require "spec_helper"
describe FirstTeamsController do
  login_admin
  
  let(:first_team) { mock_model(FirstTeam).as_null_object }
  let(:scorer) { mock(:scorer).as_null_object }
  let(:formation) { mock_model(Formation).as_null_object }
  
  before(:each) do
    Formation.stub(:new_by).with(anything).and_return(formation)
    FirstTeam.stub(:new).and_return(first_team)
    FirstTeam.stub(:find).with(anything).and_return(first_team)
    FirstTeam.stub(:last_of_the_round).and_return(formation)
    Scorer.stub(:new).with(anything).and_return(scorer)
  end
  
  describe "GET 'new'" do
    it "should load all the matches in descending order before creating a tactical formation" do
      calendar = Calendar.new
      Calendar.stub(:with_tactics).and_return(calendar)
      Calendar.should_receive(:with_tactics)
      get :new
      assigns[:matches].should eq(calendar)
    end
  end
  
  describe "GET 'index'" do
    it "displays all teams" do
      first_teams = Array.new
      FirstTeam.stub(:limit).with(20).and_return(first_teams)
      FirstTeam.should_receive(:limit).with(20)
      get :index
      assigns[:first_teams].should eq(first_teams)
    end    
  end
  
  describe "POST 'create'" do
    it "create first team and redirects to overview" do               
      FirstTeam.should_receive(:new).with(:formation => formation)
      first_team.should_receive(:save)
      post :create
    end
    
    it "should add bonus score to all users who create a squad" do
      first_team.should_receive(:apply_score).with(anything)
      post :create, :link => {:url => "http://localhost:3000/first_teams"}
    end
  end
  
  describe "GET 'last_squad_of_the_round'" do
    it "should show the last squad of the round as json" do
      FirstTeam.should_receive(:last_of_the_round)
      formation.should_receive(:as_json).with(anything)
      get :last_squad_of_the_round, :format => :json
    end
  end
  
  describe "GET 'show'" do
    it "should show the first team as json" do
      FirstTeam.should_receive(:find).with(anything)
      get :show, :format => :json
      assigns[:first_team].should eq(first_team)
      assigns[:formation].should eq(first_team.formation)
    end
  end
  
  describe "DELETE 'destroy'" do
    it "should remove selected first team" do
      FirstTeam.should_receive(:find).with(anything)
      first_team.should_receive(:destroy)
      delete :destroy
    end
  end
  
end