require File.expand_path('../../spec_helper', __FILE__)

describe GooglePagerank::Client do
  describe "when initialized" do
    before(:each) do
      @client = GooglePagerank::Client.new
    end
        
    it "should fetch pagerank for google.com" do
      @client.pagerank('http://www.google.com', {}, false).should == 10
    end
  end
end