require 'spec_helper'

describe MainsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
    it "brings the last two messages" do
      %x( ./writeit_for_testing/writeit_install_yaml.bash example_with_2_messages.yaml )
      get 'index'
      assigns(:messages).should_not be nil
      assigns(:messages).objects.length.should eql 2
      assigns(:messages).should be_an_instance_of LegislativeMessageCollection
    end
  end

end
