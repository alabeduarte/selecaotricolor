require "spec_helper"
describe ScoresController do
  context "GET 'index" do
    it "should list all users by score" do
      User.should_receive(:all_by_score)
      get :index, :link => {:url => "http://localhost:3000/scores"}
    end
  end
end