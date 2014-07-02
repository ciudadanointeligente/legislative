require 'spec_helper'


describe LegislativeAnswerRepresenter do
	it "creates an answer out of a json" do
		json = '{"content": "This is the content","created": "2014-03-17","id": 1,"resource_uri": "", "message_id": 1}'
		answer = LegislativeAnswerRepresenter.new
		answer.from_json json

		answer.content.should eql "This is the content"
        answer.created.should eql DateTime.new(2014,3,17)
        answer.message_id.should eql 1
		answer.id.should eql 1
	end
    it "loads the person who wrote the answer" do
        json = '{
                "content": "Hello I am an answer",
                "created": "2014-03-17T00:00:00",
                "id": 1,
                "person": {
                    "id": 1,
                    "image": "",
                    "name": "Gonzalo Arenas Hodar",
                    "popit_id": "5008048c7a317e126400046d",
                    "popit_url": "http://localhost:3002/api/persons/5008048c7a317e126400046d",
                    "resource_uri": "http://localhost:3002/api/persons/5008048c7a317e126400046d",
                    "summary": ""
                },
                "resource_uri": ""
                }'
        answer = LegislativeAnswerRepresenter.new
        answer.from_json json
        answer.content.should eql "Hello I am an answer"
        answer.person.should be_an_instance_of PopitPerson
        answer.person.name.should eql "Gonzalo Arenas Hodar"
        answer.person.id.should eql "5008048c7a317e126400046d"
    end
end

describe LegislativeAnswerCollection do
  it "gets the messages from the server" do
    value = %x( ./writeit_for_testing/writeit_install_yaml.bash example_with_one_message.yaml )
    collection = LegislativeAnswerCollection.new
    collection.get

    collection.objects.length.should eql 1
    answer = collection.objects[0]
    answer.should be_an_instance_of LegislativeAnswerRepresenter
    answer.content.should eql 'Hello I am an answer'
    answer.created.should eql "2014-03-17T00:00:00"
    answer.id.should eql 1
  end
end