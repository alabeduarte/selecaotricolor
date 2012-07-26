require "spec_helper"
describe FormationsController do
  login_admin
  
  let(:formation) { mock_model(Formation).as_null_object }
  let(:next_match) { mock_model(Calendar).as_null_object }
  
  before(:each) do
    Formation.stub(:new_by).with(anything).and_return(formation)
    Formation.stub(:find).with(anything).and_return(formation)
    Formation.stub(:newly_created).with(@current_user).and_return(formation)
  end
  
  describe "GET 'new'" do
    context "when doesnt there next match" do
      before do
        Calendar.stub(:next_match).and_return(nil)
      end
      it  "should redirect to root page" do
        get :new
        response.should redirect_to :root
      end
    end
    
    context "when there next match" do
      before do
        Calendar.stub(:next_match).and_return(next_match)
      end  
       
      context "when formation already created" do
        before do
          Formation.stub(:already_created?).with(@current_user, next_match).and_return(true)
          next_match.stub(:expired?).and_return(false)
        end
        it  "should redirect to root page" do
          get :new
          flash[:notice].should == I18n.t(:formation_once_per_match)
          response.should redirect_to :root
        end      
      end 
      
      context "when the match is started" do
        before do
          Formation.stub(:already_created?).with(@current_user, next_match).and_return(false)
          next_match.stub(:expired?).and_return(true)
        end
        it  "should redirect to root page" do
          get :new
          flash[:notice].should == I18n.t(:formation_time_is_over)
          response.should redirect_to :root
        end      
      end    
    end
  end
  
  describe "GET 'index'" do
    it "should redirect to new formation" do      
      get :index
      response.should redirect_to('/new')
    end    
  end
  
  describe "GET 'current_user_formations'" do
    it "should show the formation of current user" do      
      get :current_user_formations
      assigns[:formations].should eq(@current_user.formations)
    end    
  end
  
  describe "POST 'create'" do
    it "should save formation through json request" do               
      Formation.should_receive(:new_by).with(anything)
      formation.stub(:save).and_return(true)
      formation.should_receive(:save)
      post :create
    end
  end
  
  describe "GET 'newly_created'" do
    it "should show the formation of current user and flash message" do      
      Formation.should_receive(:newly_created).with(@current_user)
      get :newly_created
      flash[:notice].should == I18n.t(:formation_sent)
      response.should redirect_to :action => :show, :id => formation
    end    
  end
  
  describe "GET 'list'" do
    it "list all formations" do
      formations = Array.new
      Formation.stub(:all).and_return(formations)
      Formation.should_receive(:all)
      get :list
      assigns[:formations].should eq(formations)
    end    
  end
  
  describe "GET 'show'" do
    context "as html" do
      it "should assigns formation data" do
        Formation.should_receive(:find).with(anything)
        get :show, :format => :html
        assigns[:formation].should eq(formation)
      end      
    end
    
    context "as json" do
      it "should response with json" do
        Formation.should_receive(:find).with(anything)
        formation.should_receive(:as_json).with(anything)
        get :show, :format => :json      
      end
    end
  end
  
  describe "DELETE 'destroy'" do
    it "should remove selected first team" do
      Formation.should_receive(:find).with(anything)
      formation.should_receive(:destroy)
      delete :destroy
      flash[:notice].should == I18n.t(:formation_destroyed)
      response.should redirect_to :root
    end
  end  
  
end