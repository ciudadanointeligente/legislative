require 'spec_helper'

describe CommunicationsController do
  describe "GET 'index'" do
    it "returns http success" do
      get 'index', locale: 'es'
      response.should be_success
    end
    it "obtains list of parliamentarians" do
      get 'index', locale: 'es'
      assigns(:parliamentarians).should_not be_nil
      assigns(:parliamentarians).should be_an_instance_of PopitPersonCollection
      assigns(:parliamentarians).persons.should_not be_nil
      assigns(:parliamentarians).persons[0].should be_an_instance_of PopitPerson
    end
  end

end
