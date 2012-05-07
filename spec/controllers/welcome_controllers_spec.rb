require "spec_helper"
describe WelcomeController do
  let(:first_team) { mock_model(FirstTeam).as_null_object }
  let(:formation) { mock_model(Formation).as_null_object }
  let(:match) { mock_model(Calendar).as_null_object }
  
  context "GET 'index" do
    it "should show main action" do      
      User.should_receive(:top_scorers_of).with(5)
      FirstTeam.should_receive(:last_of_the_round)
      Calendar.should_receive(:next_match)     
      get :index, :link => {:url => "http://localhost:3000/"}
    end
    
    it "should show squad of the round" do
      recent_winners = Array.new
      positions = Array.new
                  
      formation.stub(players_ordered_by_positions: positions)
      formation.stub(match: match)
      
      FirstTeam.stub(last_of_the_round: first_team)
      first_team.stub(formation: formation)
      first_team.stub(squad_winners_of_the_round: recent_winners)
      
      get :index
      should_assign(recent_winners: recent_winners, formation: formation, players_positions: positions)
    end
    
  end
  
  context "when has some unexpected fail" do
    context "when first team dont exist" do
      it "should NOT show squad of the round" do
        FirstTeam.stub(last_of_the_round: nil)
        get :index
        should_not_assign
      end
    end
    
    context "when formation dont exist" do
      it "should NOT show squad of the round" do
        FirstTeam.stub(last_of_the_round: first_team)
        first_team.stub(formation: nil)
        get :index
        should_not_assign
      end
    end
    
    context "when players positions dont exist" do
      it "should NOT show squad of the round" do
        FirstTeam.stub(last_of_the_round: first_team)
        first_team.stub(formation: formation)
        formation.stub(players_ordered_by_positions: nil)
        get :index
        should_not_assign
      end
    end
    
    context "when last match dont exist" do
      it "should NOT show squad of the round" do
        FirstTeam.stub(last_of_the_round: first_team)
        first_team.stub(formation: formation)
        formation.stub(match: nil)
        get :index
        should_not_assign
      end
    end
  end  

private
  def should_assign(args)
    assigns[:next_match].should eq(args[:next_match])
    assigns[:recent_winners].should eq(args[:recent_winners])
    assigns[:formation].should eq(args[:formation])
  end

  def should_not_assign
    assigns[:recent_winners].should eq(nil)
    assigns[:formation].should eq(nil)
  end
end