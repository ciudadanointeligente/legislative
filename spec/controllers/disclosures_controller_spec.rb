require 'spec_helper'

describe DisclosuresController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index', locale: 'es'
      response.should be_success
    end
  end

end
