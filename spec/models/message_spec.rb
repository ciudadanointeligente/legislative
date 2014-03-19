require 'spec_helper'
#I know that I should not be testing with
# it('does something') 
#but i f**ckin love it, is so expresive :)
#there might be a time when I evolve to test like
# it(#method) but not now

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
  it "gets the messages from the server" do
    value = %x( ./writeit_for_testing/writeit_install_yaml.bash example_with_one_message.yaml )
    collection = LegislativeMessageCollection.new
    collection.get

    collection.objects.length.should eql 1
    message = collection.objects[0]
    message.should be_an_instance_of LegislativeMessageRepresenter
    message.subject.should eql 'subject 1'
    message.content.should eql 'Content 1'
  end
  it "gets a single one" do
    value = %x( ./writeit_for_testing/writeit_install_yaml.bash example_with_one_message.yaml )
    message = LegislativeMessageRepresenter.new
    message.get 1
    message.subject.should eql "subject 1"
    message.content.should eql "Content 1"
    message.id.should eql 1
    message.author_name.should eql "autor 1"
    message.author_email.should eql "test@ciudadanointeligente.org"
    message.answers.length.should eql 1
    message.answers[0].should be_an_instance_of LegislativeAnswerRepresenter
  end
  it "gets the parlamentarians" do
    value = %x( ./writeit_for_testing/writeit_install_yaml.bash example_with_one_message.yaml )
    arenas = PopitPerson.get 'http://localhost:3002/api/persons/5008048c7a317e126400046d', 'application/json'

    collection = LegislativeMessageCollection.new
    collection.get 

    collection.objects.length.should eql 1
    message = collection.objects[0]


    message.people.should include arenas
  end
  it "filter messages per person" do
    value = %x( ./writeit_for_testing/writeit_install_yaml.bash example_with_2_messages.yaml )
    # arenas = PopitPerson.get 'http://localhost:3002/api/persons/5008048c7a317e126400046d', 'application/json'
    arenas = PopitPerson.new
    arenas.id = '5008048c7a317e126400046d'

    collection = LegislativeMessageCollection.new
    collection.get(person: arenas)

    collection.objects.length.should eql 1
    message = collection.objects[0]


    message.people.should include arenas
  end
end

