require 'spec_helper'

describe PopitPersonCollection do
  it "has a list of Popit Persons including basic info" do 
    ppc = PopitPersonCollection.new
    ppc.should be_an_instance_of PopitPersonCollection
    ppc.get ENV['popit_persons'], 'application/json'
    ppc.persons.should_not be_nil
    ppc.persons[0].name.should_not be_nil
    ppc.persons[0].slug.should_not be_nil
    ppc.persons[0].images[0]['url'].should_not be_nil

  end
  it "gets one person" do
  	arenas = PopitPerson.get 'http://localhost:3002/api/persons/5008048c7a317e126400046d', 
                'application/json'
    arenas.id.should eq "5008048c7a317e126400046d"
    arenas.name.should eq "Gonzalo Arenas Hodar"
  end
end
