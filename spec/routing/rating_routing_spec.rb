require "spec_helper"

describe RatingController do  
  describe "routing" do
    let(:position) { mock_model(PlayerFormationPosition).as_null_object }
    context "rating players of first team" do
      before do
        position.stub(:id).and_return(1)
      end
      it "GET /positions/rating/:id should route to player formation position" do
        { :get => "/positions/rating/#{position.id}" }.should route_to(:controller => 'rating', :action => 'show', :id => "#{position.id}")
      end

      it "POST /positions/rating/:id should route to player formation position" do
        { :post => "/positions/rating/#{position.id}" }.should route_to(:controller => 'rating', :action => 'like', :id => "#{position.id}")
      end

      it "DELETE /positions/rating/:id should route to player formation position" do
        { :delete => "/positions/rating/#{position.id}" }.should route_to(:controller => 'rating', :action => 'unlike', :id => "#{position.id}")
      end      
    end
    
    context "rating alternate/substitutes players" do
      let(:substitution) { mock_model(Substitution).as_null_object }
      before do
        substitution.stub(:id).and_return(1)
      end
      it "GET /substitutions/rating/:id should route to player formation position" do
        { :get => "/substitutions/rating/#{substitution.id}" }.should route_to(:controller => 'rating', :action => 'show_sub', :id => "#{substitution.id}")
      end

      it "POST /positions/rating/:id should route to player formation position" do
        { :post => "/substitutions/rating/#{substitution.id}" }.should route_to(:controller => 'rating', :action => 'like_sub', :id => "#{substitution.id}")
      end

      it "DELETE /positions/rating/:id should route to player formation position" do
        { :delete => "/substitutions/rating/#{substitution.id}" }.should route_to(:controller => 'rating', :action => 'unlike_sub', :id => "#{substitution.id}")
      end      
    end
  end
end
