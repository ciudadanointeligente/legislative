require 'spec_helper'
require 'writeit-rails'

describe CommunicationsController do
  describe "GET 'index'" do
    it "returns http success" do
      get 'index', locale: 'es'
      puts response
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
      value = %x( ./writeit_for_testing/writeit_install_yaml.bash example_with_one_message.yaml )
      get 'index', locale: 'es'
      assigns(:pagination).should_not be_nil
      assigns(:pagination)['current_page'].should eql 1
      assigns(:pagination)['total_pages'].should eql 1

    end
    it "it paginates the result" do
      value = %x( ./writeit_for_testing/writeit_install_yaml.bash example_with_21_messages.yaml )
      get 'index', locale: 'es'
      assigns(:messages).objects.length.should eql ENV['writeit_messages_per_page'].to_i
      assigns(:pagination)['current_page'].should eql 1
      #This is coupled to the settings definition of writeit_messages_per_page
      # It should be calculated instead of just a plain 5
      assigns(:pagination)['total_pages'].should eql 5
    end
    it "it paginates the result" do
      value = %x( ./writeit_for_testing/writeit_install_yaml.bash example_with_21_messages.yaml )
      get 'index', locale: 'es', page: '2'
      assigns(:messages).objects.length.should eql ENV['writeit_messages_per_page'].to_i
      assigns(:pagination)['current_page'].should eql 2
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
      post :create, locale: 'es', 
                :author_name => 'autor 1',
                :author_email => 'test@ciudadanointeligente.org',
                :subject => 'subject 1',
                :content => 'Content 1',
                :recipients => [
                  "http://localhost:3002/api/persons/5008048c7a317e126400046d",
                ]

      assigns(:message).should_not be_nil
      assigns(:message).writeitinstance.base_url.should eql ENV['writeit_base_url']
      assigns(:message).writeitinstance.url.should eql ENV['writeit_url']
      assigns(:message).writeitinstance.username.should eql ENV['writeit_username']
      assigns(:message).writeitinstance.api_key.should eql ENV['writeit_api_key']
      assigns(:message).remote_uri.should_not be_nil
      assigns(:message).remote_id.should_not be_nil
      assigns(:message).should be_an_instance_of Message
      response.status.should eql 200

    end

    it "get per person messages" do
      %x( ./writeit_for_testing/writeit_install_yaml.bash example_with_2_messages.yaml )
      get :per_person, :id => "5008048c7a317e126400046d", locale: 'es'

      #the person with id 5008048c7a317e126400046d is
      #gonzalo arenas
      # i get something like 
      arenas = PopitPerson.get 'http://localhost:3002/api/persons/5008048c7a317e126400046d', 
                'application/json'
      #response.should route_to("communications#per_person", :id => "5008048c7a317e126400046d")
      #this is gonzalo arenas
      response.should be_success
      assigns(:person).should eql arenas
      assigns(:messages).objects.should_not be_empty
      assigns(:messages).objects.length.should eql 1
      
      message = assigns(:messages).objects[0]
      message.content.should eql "Content 1"
      message.author_name.should eql "autor 1"
    end
    it "should return 404 if the person does not exist" do
      %x( ./writeit_for_testing/writeit_install_yaml.bash example_with_2_messages.yaml )
      get :per_person, :id => "5008048c7a317e12640d", locale: 'es'
      response.status.should eql 404
    end

    it "should return 200 even if there is a problem in writeit" do
      %x( ./writeit_for_testing/writeit_install_yaml.bash example_with_2_messages.yaml )
      # this guy produces an error in write it
      get :per_person, :id => "500804717a317e126400005e", :locale => 'es'
      response.status.should eql 200
    end
    it "has a page per message" do
      %x( ./writeit_for_testing/writeit_install_yaml.bash example_with_2_messages.yaml )
      get :per_message, :locale => 'es', :id=> '1'
      response.should be_success
      assigns(:message).content.should eql "Content 1"
    end
  end
end
