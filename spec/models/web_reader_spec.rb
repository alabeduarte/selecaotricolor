require 'spec_helper'

describe WebReader do
  let(:ec_bahia) { ec_bahia = WebReader.new('http://www.ecbahia.com') }
  
  it "should fetch ecbahia title" do
    ec_bahia.title.should == "ecbahia.com - \u00e9 goleada tricolor na internet!  (ecbahia, ecbahia.com, ecbahia.com.br, Esporte Clube Bahia)"
  end
  
end
