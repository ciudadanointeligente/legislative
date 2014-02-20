require 'spec_helper'
require 'writeit-rails'

describe CommunicationsController do
  describe "GET 'index'" do
    it "returns http success" do
      get :index, locale: 'es'
      response.should be_success
    end
    
  end
  describe "writeit form creation" do

    it "obtains list of congressmen" do
      get 'index', locale: 'es'
      assigns(:congressmen).should_not be_nil
      assigns(:congressmen).should be_an_instance_of PopitPersonCollection
      assigns(:congressmen).persons.should_not be_nil
      assigns(:congressmen).persons[0].should be_an_instance_of PopitPerson
    end
    it "obtains list of messages" do
      value = %x( ./writeit_for_testing/writeit_install_yaml.bash example_with_one_message.yaml )
      get 'index', locale: 'es'
      assigns(:messages).should_not be_nil
      assigns(:messages).should be_an_instance_of LegislativeMessageCollection
      assigns(:messages).objects.should_not be_nil
      assigns(:messages).objects[0].should be_an_instance_of LegislativeMessageRepresenter

    end
    it "obtains the pagination things" do
      get 'index', locale: 'es'
      assigns(:pagination).should_not be_nil
      assigns(:pagination)['current_page'].should eql 1
      assigns(:pagination)['total_pages'].should eql 1

    end
    it "instanciates a writeit instance based on environment" do
      controller = CommunicationsController.new
      controller.instance_eval{ set_current_instance }
      controller.instance_eval{ @writeitinstance }.should be_an_instance_of WriteItInstance
      controller.instance_eval{ @writeitinstance }.base_url.should eql ENV['writeit_base_url']
      controller.instance_eval{ @writeitinstance }.url.should eql ENV['writeit_url']
      controller.instance_eval{ @writeitinstance }.username.should eql ENV['writeit_username']
      controller.instance_eval{ @writeitinstance }.api_key.should eql ENV['writeit_api_key']
      controller.instance_eval{ @writeitinstance }.per_page.should eql ENV['writeit_messages_per_page']
    end

    it "Form Post trigger pushing to the writeit API" do
      #testing that clicking the submit button triggers the push to the API method of the writeit-rails gem
      congressmen = PopitPersonCollection.new
      congressmen.get ENV['popit_persons'], 'application/json'
      congressman1 = congressmen.persons[0]
      post :create, locale: 'es', 
                :author_name => 'autor 1',
                :author_email => 'test@ciudadanointeligente.org',
                :subject => 'subject 1',
                :content => 'Content 1',
                :recipients => [
                  congressman1.popit_api_uri,
                ]

      assigns(:message).should_not be_nil
      assigns(:message).writeitinstance.base_url.should eql ENV['writeit_base_url']
      assigns(:message).writeitinstance.url.should eql ENV['writeit_url']
      assigns(:message).writeitinstance.username.should eql ENV['writeit_username']
      assigns(:message).writeitinstance.api_key.should eql ENV['writeit_api_key']
      assigns(:message).remote_uri.should_not be_nil
      assigns(:message).remote_id.should_not be_nil
      assigns(:message).should be_an_instance_of Message

    end
  end
end
