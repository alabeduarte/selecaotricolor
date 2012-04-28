require "spec_helper"
describe NewslettersController do  
  login_admin
  context "GET 'index" do
    it "should list all email's users by score" do      
      users = Array.new
      User.should_receive(:all_by_score).and_return(users)
      Newsletter.should_receive(:all).with(users)
      get :index, :link => {:url => "http://localhost:3000/newsletters"}
    end
  end
  
end