require 'spec_helper'
describe CalendarsController do
  let(:match) { mock_model(Calendar).as_null_object }
  context "GET 'index" do
    it "should show all formations of some match" do
      Calendar.stub(find: match)
      match.stub(formations: Array.new)
      get :formations_matches, :id => 1
      should_assign match: match
    end

    context "when next match don't exist" do
      it "should redirect to welcome#index" do
        Calendar.stub(find: nil)
        get :formations_matches, :id => 1
        response.should redirect_to '/'
      end
    end
  end

private
  def should_assign(args)
    assigns[:match].should eq(args[:match])
  end
end
