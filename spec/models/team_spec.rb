require 'spec_helper'
describe Team do
  context "linkfiy names for teams below" do
    it "should linkify Bahia" do
      team = Team.new name: "Bahia"
      team.label.should == "bahia"
    end
    
    it "should linkify Atl\u00e9tico de Alagoinhas" do
      team = Team.new name: "Atl\u00e9tico de Alagoinhas"
      team.label.should == "atleticodealagoinhas"
    end
    
    it "should linkify Vit\u00f3ria" do
      team = Team.new name: "Vit\u00f3ria"
      team.label.should == "vitoria"
    end
  end
end