require 'spec_helper'

describe CommunicationsController do
  describe "GET 'index'" do
    it "returns http success" do
      get 'index', locale: 'es'
      response.should be_success
    end
    
  end
  describe "writeit form creation" do

    it "obtains list of parliamentarians" do
      get 'index', locale: 'es'
      assigns(:parliamentarians).should_not be_nil
      assigns(:parliamentarians).should be_an_instance_of PopitPersonCollection
      assigns(:parliamentarians).persons.should_not be_nil
      assigns(:parliamentarians).persons[0].should be_an_instance_of PopitPerson
    end
    it "Form Post trigger pushing to the writeit API" do
      #testing that clicking the submit button triggers the push to the API method of the writeit-rails gem
      parliamentarian1 = PopitPerson.find(1)
      puts parliamentarian1
      post 'index', 
        data: {
                :author_name => 'autor 1',
                :author_email => 'test@ciudadanointeligente.org',
                :subject => 'subject 1',
                :content => 'Content 1',
                :persons => parliamentarian1.popit_web_url
            }
    end
  end
end
