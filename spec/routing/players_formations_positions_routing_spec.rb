require "spec_helper"

describe PlayersFormationsPositionsController do
  let(:position) { mock_model(PlayerFormationPosition).as_null_object }
  describe "routing" do
    before do
      position.stub(:id).and_return(1)
    end
    it "GET /positions/rating/:id should route to player formation position" do
      { :get => "/positions/rating/#{position.id}" }.should route_to(:controller => 'players_formations_positions', :action => 'show', :id => "#{position.id}")
    end
    
    it "POST /positions/rating/:id should route to player formation position" do
      { :post => "/positions/rating/#{position.id}" }.should route_to(:controller => 'players_formations_positions', :action => 'like', :id => "#{position.id}")
    end
    
    it "DELETE /positions/rating/:id should route to player formation position" do
      { :delete => "/positions/rating/#{position.id}" }.should route_to(:controller => 'players_formations_positions', :action => 'unlike', :id => "#{position.id}")
    end
  end
end
