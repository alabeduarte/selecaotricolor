require "spec_helper"
describe SubstitutionsController do
  login_admin
  
  let(:first_team) { mock_model(FirstTeam).as_null_object }
  
  describe "get 'new'" do
    it "should preload all first teams" do
      FirstTeam.should_receive(:all_by_match)
      get :new
      response.should be_success
    end
  end
  
  describe "post 'create'" do
    before do
      FirstTeam.stub(:find).and_return(first_team)      
      first_team.stub(:save).and_return(true)
    end
    it "should update first team with substitutions" do
      FirstTeam.should_receive(:find).with(anything)
      first_team.should_receive(:<<)      
      first_team.should_receive(:save)
      post :create      
      flash[:notice].should == I18n.t(:replacement_registered_successfully)
      response.should be_success
    end
  end
  
  describe "get 'show'" do
    it "should show substitution with off and on players" do
      substitution = mock_model(Substitution).as_null_object
      Substitution.stub(:find).with("1").and_return(substitution)
      Substitution.should_receive(:find).with("1")
      get :show, :id => "1"
      assigns[:substitution].should eq(substitution)
      response.should be_success
    end
  end
  
end