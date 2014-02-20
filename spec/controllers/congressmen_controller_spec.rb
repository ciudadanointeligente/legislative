require 'spec_helper'

describe CongressmenController do
  describe "GET 'index'" do
    it "returns http success" do
      get 'index', locale: 'es'
      response.should be_success
    end
    it "obtains list of congressmen" do
      get 'index', locale: 'es'
      assigns(:congressmen).should_not be_nil
      assigns(:congressmen).should be_an_instance_of PopitPersonCollection
      assigns(:congressmen).persons.should_not be_nil
      assigns(:congressmen).persons[0].should be_an_instance_of PopitPerson

    end
  end

end
