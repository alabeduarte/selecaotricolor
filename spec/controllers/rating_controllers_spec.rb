require "spec_helper"
describe RatingController do
  let(:player) { mock_model(Player).as_null_object }
  let(:match) { mock_model(Calendar).as_null_object }
  
  describe "when rating player position" do
    let(:position) { mock_model(PlayerFormationPosition).as_null_object }
    before do
      PlayerFormationPosition.stub(:find).with(anything).and_return(position)
      position.stub(:player).and_return(player)
      position.stub_chain(:formation, :match).and_return(match)
    end

    describe "GET '/positions/rating/:id'" do
      it "should display player info on match" do
        PlayerFormationPosition.should_receive(:find).with(anything)
        get :show
        response.should be_success
        assigns[:player].should eq(player)
      end    
    end

    describe "POST '/positions/rating/:id'" do
      it "should increase rating for player on match" do
        PlayerFormationPosition.should_receive(:find).with(anything)
        position.should_receive(:player)
        player.should_receive(:increase_rating)
        post :like, :id => position.id
        response.should be_success
      end    
    end

    describe "DELETE '/positions/rating/:id'" do
      it "should decrease rating for player on match" do
        PlayerFormationPosition.should_receive(:find).with(anything)
        position.should_receive(:player)
        player.should_receive(:decrease_rating)
        delete :unlike, :id => position.id
        response.should be_success
      end    
    end
  end
  
  describe "when rating substitution" do
    let(:substitution) { mock_model(Substitution).as_null_object }    
    before do
      Substitution.stub(:find).with(anything).and_return(substitution)
      substitution.stub(:on).and_return(player)
      substitution.stub_chain(:first_team, :formation, :match).and_return(match)
    end

    describe "GET '/substitutions/rating/:id'" do
      it "should display player info on match" do
        Substitution.should_receive(:find).with(anything)
        get :show_sub
        response.should be_success
        assigns[:match].should eq(match)
        assigns[:player].should eq(player)
      end    
    end

    describe "POST '/substitutions/rating/:id'" do
      it "should increase rating for player on match" do
        Substitution.should_receive(:find).with(anything)
        substitution.should_receive(:on)
        player.should_receive(:increase_rating)
        post :like_sub, :id => substitution.id
        response.should be_success
      end    
    end

    describe "DELETE '/substitutions/rating/:id'" do
      it "should decrease rating for player on match" do
        Substitution.should_receive(:find).with(anything)
        substitution.should_receive(:on)
        player.should_receive(:decrease_rating)
        delete :unlike_sub, :id => substitution.id
        response.should be_success
      end    
    end
  end  
end