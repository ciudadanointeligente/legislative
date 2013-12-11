require 'spec_helper'

describe PopitPerson do
  it "has a popit web url" do
    ppc = PopitPersonCollection.new
    WebMock.disable_net_connect! allow: [ENV['popit_url']]
    ppc.get ENV['popit_persons'], 'application/json'
    pp = ppc.persons[0]
    pp.popit_web_url.should_not be_nil
  end
  it "has a valid web url" do
    ppc = PopitPersonCollection.new
    WebMock.disable_net_connect! allow: [ENV['popit_url']]
    ppc.get ENV['popit_persons'], 'application/json'
    pp = ppc.persons[0]
    response = RestClient.get pp.popit_web_url
    response.code.should equal 200

  end
end
