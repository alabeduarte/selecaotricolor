require "spec_helper"
describe SubstitutionsController do
  login_admin
  
  let(:first_team) { mock_model(FirstTeam).as_null_object }
  
  describe "GET 'index'" do
    it "should load all substitutions" do
      Substitution.should_receive(:all)
      get :index
      response.should be_success
    end
  end
  
  describe "GET 'new'" do
    it "should preload all first teams" do
      FirstTeam.should_receive(:all_by_match)
      get :new
      response.should be_success
    end
  end
  
  describe "POST 'create'" do
    it "should create new substitution" do
      substitution = mock_model(Substitution).as_null_object
      substitution.stub(:save).and_return(true)
      Substitution.stub(:new).with({'these' => 'params'}).and_return(substitution)
      post :create, :substitution => {'these' => 'params'}
      assigns(:substitution).should be(substitution)
    end
  end
  
  describe "GET 'show'" do
    it "should show substitution with off and on players" do
      substitution = mock_model(Substitution).as_null_object
      Substitution.stub(:find).with("1").and_return(substitution)
      Substitution.should_receive(:find).with("1")
      get :show, :id => "1"
      assigns[:substitution].should eq(substitution)
      response.should be_success
    end
  end
  
  describe "DELETE destroy" do
    it "destroys the requested substitution" do
      substitution = mock_model(Substitution).as_null_object
      Substitution.stub(:find).with("1").and_return(substitution)
      substitution.should_receive(:destroy)
      delete :destroy, :id => "1"
    end

    it "redirects to the new substitution" do
      substitution = mock_model(Substitution).as_null_object
      Substitution.stub(:find).with("1").and_return(substitution)
      delete :destroy, :id => "1"
      response.should redirect_to(:action => :index)
    end
  end
  
end