require "spec_helper"
require "models/formation/helper"

describe FirstTeam do 
  
  let(:first_team) { mock_model(FirstTeam).as_null_object }
  let(:scorer) { mock(:scorer).as_null_object }
  let(:formation) { mock_model(Formation).as_null_object }
  let(:new_first_team) { FirstTeam.new(formation: formation) }
  
  context "scoring players" do
    it "should make reference with scorer before apply scores" do
      scorer.should_receive(:first_team=).with(new_first_team)
      new_first_team.apply_score(scorer)
    end
    
    it "should add bonus score to all users who create a squad" do      
      new_first_team.should_receive(:apply_score_to_all_users)
      new_first_team.apply_score(scorer)
    end

    it "should score all users must predict the squad" do
      new_first_team.should_receive(:apply_score_to_predict_users)
      new_first_team.apply_score(scorer)
    end
    
    it "should associate new formation when first team w'll created" do
      new_first_team.formation.should_not be_nil
    end
  end
end