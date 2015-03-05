require File.expand_path('../../spec_helper', __FILE__)

describe Google::Pagerank::Client do
  describe "when initialized" do
    before(:each) do
      @client = Google::Pagerank::Client.new
    end
        
    it "should correctly fetch pagerank for google.com" do
      expect(@client.pagerank('google.com')).to eq(9)
    end
  end
end