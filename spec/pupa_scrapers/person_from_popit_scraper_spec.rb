require 'spec_helper'
require 'pupa'
require 'htmlentities'
require 'json'
require 'open-uri'
require 'webmock/rspec'
require 'popolo'
require './lib/scrapers/person_scraper'

WebMock.disable_net_connect!(:allow => /popoloproject.com/)

describe PersonScraper , "The person Scrapper" do
  def connection
    Pupa::Processor::Connection::MongoDBAdapter.new('mongodb://localhost:27017/pupa')
  end
  context "initialization" do
    it "is a kind of Pupa::Processor" do
      scrapper = PersonScraper.new './results'
      expect(scrapper).to be_a Pupa::Processor
    end
  end
  context "scrapping objects" do 
  	before :all do
      
  		$file = File.read('./spec/fixtures/congressmen.json')
      $file2 = File.read('./spec/fixtures/congressmen2.json')
  		$persons_json = JSON.parse($file)
  		$scrapper = PersonScraper.new "results"
      PersonScraper.add_scraping_task(:people)
    end
    before :each do
      stub_request(:any, "http://pmocl.popit.mysociety.org/api/v0.1/persons").to_return(:body => $file)
      stub_request(:any, "http://pmocl.popit.mysociety.org/api/v0.1/persons?page=2").to_return(:body => $file2)
      Popolo::Person.all().delete()
    end
    after :each do
      connection.raw_connection[:people].drop
    end
    it "creates persons from the file" do
      # I'm expecting to have a lot of people stored in my db
      # allow(OpenURI).to receive(:open).and_return("Whatever for now")
      # read.stub(:read).and_return('log-level set to 1')
      # allow($scrapper).to receive(:open).and_return($file)
      runner = Pupa::Runner.new(PersonScraper)
      runner.run([])
      result = connection.find(_type: 'pupa/person', name: 'Jorge Pizarro Soto')
      result.should be_a(Hash)
      
      expect(result["name"]).to eq("Jorge Pizarro Soto")
      expect(result["identifiers"]).to include({"identifier"=>"53303739d0c05d8b737b6ce6"})
      expect(result["other_names"]).to include({'name'=>'Pizarro S., Jorge', "note"=>"For voting"})
  	end
    it "scrapes paginated" do
      

      runner = Pupa::Runner.new(PersonScraper)
      runner.run([])

      raw_connection = connection.raw_connection
      collection = raw_connection[:people]

      query = collection.find()
      
      expect(query.count).to eq(60)
      
    end

    it "uses popolo engine" do
    	runner = Pupa::Runner.new(PersonScraper)
      runner.run([])

    	p = Popolo::Person.where(:name => "Gabriel Boric Font")
      expect(p.count).to eq(1)
    end
  end
end