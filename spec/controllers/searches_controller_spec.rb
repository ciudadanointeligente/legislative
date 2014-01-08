require 'spec_helper'

describe SearchesController do
  describe "GET index" do
    it "returns a BillCollectionPage" do
      raw_response_file = File.open("./spec/webmock/bills_salud_page1.json")
      stub_request(:get, "http://billit.ciudadanointeligente.org/bills/search/?q=salud").
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => raw_response_file, :headers => {})

      raw_response_file_authors = File.open("./spec/webmock/bill_authors_list.json")
      stub_request(:get, 'http://' + ENV['popit_url']  + '/api/v0.1/persons/').
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => raw_response_file_authors, :headers => {})

      get :index, {q: 'salud', locale: 'es'}
      assigns(:bills_query).should be_an_instance_of BillCollectionPage
    end

    it "returns an array of Bills" do
      raw_response_file = File.open("./spec/webmock/bills_salud_page1.json")
      stub_request(:get, "http://billit.ciudadanointeligente.org/bills/search/?q=salud").
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => raw_response_file, :headers => {})

      raw_response_file_authors = File.open("./spec/webmock/bill_authors_list.json")
      stub_request(:get, 'http://' + ENV['popit_url']  + '/api/v0.1/persons/').
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => raw_response_file_authors, :headers => {})

      get :index, q: 'salud', locale: 'es'
      assigns(:bills_query).bills.should_not be_nil
      assigns(:bills_query).bills.should be_an Array
      assigns(:bills_query).bills[0].should be_an_instance_of Bill
    end

    it "has a self reference" do
      raw_response_file = File.open("./spec/webmock/bills_salud_page1.json")
      stub_request(:get, "http://billit.ciudadanointeligente.org/bills/search/?q=salud").
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => raw_response_file, :headers => {})

      raw_response_file_authors = File.open("./spec/webmock/bill_authors_list.json")
      stub_request(:get, 'http://' + ENV['popit_url']  + '/api/v0.1/persons/').
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => raw_response_file_authors, :headers => {})

      get :index, q: 'salud', locale: 'es'
      assigns(:bills_query).self.should_not be_nil
      assigns(:bills_query).self.should eq(ENV['billit'] + "/search?&page=1&q=salud")
    end

    it "has a next page" do
      WebMock.disable_net_connect!(allow_localhost: true)

      get :index, q: 'arica', per_page: '2', locale: 'es'
      assigns(:bills_query).next.should eq(ENV['billit'] + "/search?page=2&per_page=2&q=arica")
    end

    it "has a previous page" do
      raw_response_file = File.open("./spec/webmock/bills_salud_page2.json")
      stub_request(:get, "http://billit.ciudadanointeligente.org/bills/search/?page=2&q=salud").
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => raw_response_file, :headers => {})

      raw_response_file_authors = File.open("./spec/webmock/bill_authors_list.json")
      stub_request(:get, 'http://' + ENV['popit_url']  + '/api/v0.1/persons/').
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => raw_response_file_authors, :headers => {})

      get :index, q: 'salud', locale: 'es', page: 2
      assigns(:bills_query).previous.should eq("http://billit.ciudadanointeligente.org/bills/search?&page=1&q=salud")
    end

    it "has all metadata" do
      raw_response_file = File.open("./spec/webmock/bills_salud_page1.json")
      stub_request(:get, "http://billit.ciudadanointeligente.org/bills/search/?q=salud").
        with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => raw_response_file, :headers => {})

      raw_response_file_authors = File.open("./spec/webmock/bill_authors_list.json")
      stub_request(:get, 'http://' + ENV['popit_url']  + '/api/v0.1/persons/').
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => raw_response_file_authors, :headers => {})

      get :index, q: 'salud', locale: 'es'
      assigns(:bills_query).total_entries.should_not be_nil
      assigns(:bills_query).current_page.should_not be_nil
      assigns(:bills_query).total_pages.should_not be_nil
    end

    it "it obtains authors list" do
      raw_response_file = File.open("./spec/webmock/bill_authors_list.json")
      stub_request(:get, 'http://' + ENV['popit_url']  + '/api/v0.1/persons/').
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => raw_response_file, :headers => {})

      get :index, locale: 'es'
      assigns(:authors_list).should_not be_nil
      assigns(:authors_list).should_not be_empty
    end
  end
end
