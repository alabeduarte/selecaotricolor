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
    it "should create new substitution" do
      substitution = mock_model(Substitution).as_null_object
      substitution.stub(:save).and_return(true)
      Substitution.stub(:new).with({'these' => 'params'}).and_return(substitution)
      post :create, :substitution => {'these' => 'params'}
      assigns(:substitution).should be(substitution)
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