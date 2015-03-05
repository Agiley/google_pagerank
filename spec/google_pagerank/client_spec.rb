require File.expand_path('../../spec_helper', __FILE__)

describe Google::Pagerank::Client do
  describe "when initialized" do
    before(:each) do
      @client   =   Google::Pagerank::Client.new
    end
        
    it "should correctly fetch pagerank for google.com" do
      pagerank  =   @client.pagerank('google.com')
      expect(pagerank).to eq(9)
    end
  end
end