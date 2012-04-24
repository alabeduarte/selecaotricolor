require 'spec_helper'
describe Newsletter do
  context "email listing" do
    it "should listing all emails separated by commas" do
      users = Array.new
      users << User.new(email: "test1@t.com")
      users << User.new(email: "test2@t.com")
      users << User.new(email: "test3@t.com")
      users << User.new(email: "test4@t.com")
      users << User.new(email: "test5@t.com")
      User.stub(:all_by_score).and_return(users)
      Newsletter.all(users).should == "test1@t.com, test2@t.com, test3@t.com, test4@t.com, test5@t.com"
    end
    
    it "should listing blank when without emails" do
      users = Array.new
      User.stub(:all_by_score).and_return(users)
      Newsletter.all(users).should == ""
    end
  end
end