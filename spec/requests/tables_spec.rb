require 'spec_helper'

describe "Tables" do
  describe "GET /tables" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      stub_request(:get, ENV["tables"]).
         with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => "", :headers => {})
      get tables_path
      response.status.should be(200)
    end
  end
end
