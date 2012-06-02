require "spec_helper"
describe PlayersFormationsPositionsController do
  let(:position) { mock_model(PlayerFormationPosition).as_null_object }
  let(:player) { mock_model(Player).as_null_object }
  
  before do
    PlayerFormationPosition.stub(:find).with(anything).and_return(position)
    position.stub(:player).and_return(player)
  end
  
  describe "GET '/show/:id'" do
    it "should display player info on match" do
      PlayerFormationPosition.should_receive(:find).with(anything)
      get :show
      response.should be_success
      assigns[:position].should eq(position)
    end    
  end
  
  describe "POST '/like/:id'" do
    it "should increase rating for player on match" do
      PlayerFormationPosition.should_receive(:find).with(anything)
      position.should_receive(:player)
      player.should_receive(:increase_rating)
      post :like
      response.should be_success
    end    
  end
  
  describe "DELETE '/like/:id'" do
    it "should decrease rating for player on match" do
      PlayerFormationPosition.should_receive(:find).with(anything)
      position.should_receive(:player)
      player.should_receive(:decrease_rating)
      delete :unlike
      response.should be_success
    end    
  end
end