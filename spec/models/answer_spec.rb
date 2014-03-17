require 'spec_helper'


describe LegislativeAnswerRepresenter do
	it "creates an answer out of a json" do
		json = '{"content": "This is the content","created": "2014-03-17","id": 1,"resource_uri": ""}'
		answer = LegislativeAnswerRepresenter.new
		answer.from_json json

		answer.content.should eql "This is the content"
		answer.created.should eql DateTime.new(2014,3,17)
		answer.id.should eql 1
	end
end