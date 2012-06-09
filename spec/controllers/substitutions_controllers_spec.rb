require "spec_helper"
describe SubstitutionsController do
  login_admin
  
  let(:first_team) { mock_model(FirstTeam).as_null_object }
  
  describe "post 'create'" do
    before do
      FirstTeam.stub(:find).with(anything).and_return(first_team)
      first_team.stub(:update_attributes).with(anything).and_return(true)
    end
    it "should update first team with substitutions" do
      FirstTeam.should_receive(:find).with(anything)
      first_team.should_receive(:update_attributes).with(anything)
      post :create      
      flash[:notice].should == I18n.t(:replacement_registered_successfully)
    end
  end
  
end