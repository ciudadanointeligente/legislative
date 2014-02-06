require 'spec_helper'
# require 'popit_representers'

describe LegislativeMessageRepresenter do
  it "has a method from_json " do
    message = LegislativeMessageRepresenter.new
    message_json = '{"subject":"subject","content":"content","recipients":"recipients","id":"remote_id","author_name":"author_name","author_email":"author_email"}'
    message.from_json(message_json)

    message.subject.should eql "subject"
    message.content.should eql "content"
    message.id.should eql "remote_id"
    message.author_name.should eql "author_name"
    message.author_email.should eql "author_email"
  end
end

describe LegislativeMessageCollection do
  before(:each) do
    value = %x( ./writeit_for_testing/writeit_install_yaml.bash example_with_one_message.yaml )
  end

  it "gets the messages from the server" do
    collection = LegislativeMessageCollection.new
    collection.get

    collection.objects.length.should eql 1
    message = collection.objects[0]
    message.should be_an_instance_of LegislativeMessageRepresenter
    message.subject.should eql 'subject 1'
    message.content.should eql 'Content 1'
  end
  it "gets a single one" do
    message = LegislativeMessageRepresenter.new
    message.get 1
    message.subject.should eql "subject 1"
    message.content.should eql "Content 1"
    message.id.should eql 1
    message.author_name.should eql "autor 1"
    message.author_email.should eql "test@ciudadanointeligente.org"
  end
  it "gets the parlamentarians" do
    arenas = PopitPerson.get 'http://localhost:3002/api/persons/5008048c7a317e126400046d', 'application/json'

    collection = LegislativeMessageCollection.new
    collection.get 

    collection.objects.length.should eql 1
    message = collection.objects[0]


    message.people.should include arenas
  end
end

