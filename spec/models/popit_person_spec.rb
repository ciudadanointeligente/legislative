require 'spec_helper'

describe PopitPerson do
  it "has a popit web url" do
    ppc = PopitPersonCollection.new
    ppc.get ENV['popit_persons'], 'application/json'
    pp = ppc.persons[0]
    pp.popit_api_uri.should_not be_nil
  end

  xit "has a valid web url" do
    #it should point to a web popit, currently we only include a popit api
    ppc = PopitPersonCollection.new
    ppc.get ENV['popit_persons'], 'application/json'
    pp = ppc.persons[0]
    response = RestClient.get pp.popit_web_url
    response.code.should equal 200
  end
  it "has a valid API URI" do
    ppc = PopitPersonCollection.new
    ppc.get ENV['popit_persons'], 'application/json'
    pp = ppc.persons[0]
    response = RestClient.get pp.popit_api_uri
    response.code.should equal 200
  end
  it "loads a person from two different jsons" do
    json_with_result = '{
        "result": {
          "id": "5008048c7a317e126400046d",
          "name": "Gonzalo Arenas Hodar",
          "slug": "gonzalo-arenas-hodar",
          "images": [
            {
              "url": "http://legislativo.votainteligente.cl/images/parlamentarios/134.png"
            }
          ],
          "memberships": [],
          "links": [],
          "contact_details": [],
          "identifiers": [],
          "other_names": []
        }
      }'
    arenas = PopitPerson.new
    arenas.from_json json_with_result
    arenas.id.should eq "5008048c7a317e126400046d"
    arenas.name.should eq "Gonzalo Arenas Hodar"
  end
  it "loads a person from writeit as well" do
    json_with_result = '{
              "id": 15556,
              "image": "",
              "name": "Daniel NÃºÃ±ez Arancibia",
              "popit_id": "53189f1f6669ce99248f1a44",
              "popit_url": "http://pmocl.popit.mysociety.org/api/v0.1/persons/53189f1f6669ce99248f1a44",
              "resource_uri": "http://pmocl.popit.mysociety.org/api/v0.1/persons/53189f1f6669ce99248f1a44",
              "summary": ""
              }'
    person = PopitPerson.new
    person.from_json json_with_result
    person.id.should eq "53189f1f6669ce99248f1a44"
    person.name.should eq "Daniel NÃºÃ±ez Arancibia"
  end
end
