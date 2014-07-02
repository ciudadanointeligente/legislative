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
      assigns(:answers).should_not be nil
      assigns(:answers).objects.length.should eql 2
      assigns(:answers).should be_an_instance_of LegislativeAnswerCollection
    end
  end

end
