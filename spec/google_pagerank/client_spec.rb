require File.expand_path('../../spec_helper', __FILE__)

describe Google::Pagerank::Client do
  describe "when initialized" do
    before(:each) do
      @client = Google::Pagerank::Client.new
    end
        
    it "should fetch pagerank for google.com" do
      @client.pagerank('http://www.google.com').should == 9
    end
  end
end