require 'spec_helper'

describe PopitPersonCollection do
  it "has a list of Popit Persons including basic info" do 
    ppc = PopitPersonCollection.new
    ppc.should be_an_instance_of PopitPersonCollection
    WebMock.disable_net_connect! allow: [ENV['popit_url']]
    ppc.get ENV['popit_persons'], 'application/json'
    ppc.persons.should_not be_nil
    ppc.persons[0].name.should_not be_nil
    ppc.persons[0].slug.should_not be_nil
    ppc.persons[0].images[0]['url'].should_not be_nil

  end
end
