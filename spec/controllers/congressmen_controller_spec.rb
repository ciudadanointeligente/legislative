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
  it "shows only one congressman" do
    get :show, :id => "5008048c7a317e126400046d", locale: 'es'
    assigns(:congressman).id.should eql "5008048c7a317e126400046d"
    assigns(:congressman).should be_a_kind_of PopitPerson
  end

  it "brings the last message for that person" do
    get :show, :id => "5008048c7a317e126400046d", locale: 'es'
    assigns(:message).should_not be_nil
    assigns(:message).should be_a_kind_of LegislativeMessageRepresenter
  end

end
