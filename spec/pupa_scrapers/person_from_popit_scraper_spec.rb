require 'spec_helper'
require 'pupa'
require 'htmlentities'
require 'json'
require 'open-uri'
require 'webmock/rspec'
require 'popolo'
require './lib/scrapers/person_scraper'

WebMock.disable_net_connect!(:allow => /popoloproject.com/)

describe CongresoAbiertoScrapers::PersonScraper , "The person Scrapper" do
  def connection
    Pupa::Processor::Connection::MongoDBAdapter.new('mongodb://localhost:27017/pupa')
  end
  context "initialization" do
    it "is a kind of Pupa::Processor" do
      scrapper = CongresoAbiertoScrapers::PersonScraper.new './results'
      expect(scrapper).to be_a Pupa::Processor
    end
  end
  context "scrapping objects" do 
  	before :all do
      
  		$file = File.read('./spec/fixtures/congressmen.json')
      $file2 = File.read('./spec/fixtures/congressmen2.json')
  		$persons_json = JSON.parse($file)
  		$scrapper = CongresoAbiertoScrapers::PersonScraper.new "results"
    end
    before :each do
      stub_request(:any, "http://pmocl.popit.mysociety.org/api/v0.1/persons").to_return(:body => $file)
      stub_request(:any, "http://pmocl.popit.mysociety.org/api/v0.1/persons?page=2").to_return(:body => $file2)
    end
    after :each do
      connection.raw_connection[:people].drop
    end
    it "creates persons from the file" do
      # I'm expecting to have a lot of people stored in my db
      # allow(OpenURI).to receive(:open).and_return("Whatever for now")
      # read.stub(:read).and_return('log-level set to 1')
      # allow($scrapper).to receive(:open).and_return($file)
      runner = Pupa::Runner.new(CongresoAbiertoScrapers::PersonScraper)
      runner.run([])
      result = connection.find(_type: 'pupa/person', name: 'Jorge Pizarro Soto')
      result.should be_a(Hash)
      
      expect(result["name"]).to eq("Jorge Pizarro Soto")
      expect(result["identifiers"]).to include({"identifier"=>"53303739d0c05d8b737b6ce6"})
      expect(result["other_names"]).to include({'name'=>'Pizarro S., Jorge', "note"=>"For voting"})
  	end
    it "scrapes paginated" do
      

      runner = Pupa::Runner.new(CongresoAbiertoScrapers::PersonScraper)
      runner.run([])

      raw_connection = connection.raw_connection
      collection = raw_connection[:people]

      query = collection.find()
      
      expect(query.count).to eq(60)
      
    end
    context "using Popolo Engine" do
      before :each do
      	@runner = Pupa::Runner.new(CongresoAbiertoScrapers::PersonScraper)
        @runner.run([])
      end
      it "saves at least one person" do

      	p = Popolo::Person.where(:name => "Gabriel Boric Font")
        expect(p.count).to eq(1)
      end
      it "searching using popit id" do
        p = Popolo::Person.where(:_id => '53303694d0c05d8b737b6c59')
        expect(p.count).to eq(1)
        persona = p.first
        expect(persona.name).to eq('Gabriel Boric Font')

        p2 = Popolo::Person.where(:id => '53303694d0c05d8b737b6c59')
        expect(p2.count).to eq(1)
        persona = p2.first
        expect(persona.name).to eq('Gabriel Boric Font')

      end
      it "contains all the extra attributes" do
        p = Popolo::Person.where(:_id => '5330369ed0c05d8b737b6c86').first
        expect(p.name).to eq('Gustavo Hasbún Selume') 
        expect(p.birth_date).to eq(Date.strptime('1972-08-02'))
        expect(p.honorific_prefix).to eq("Diputado")
        expect(p.image).to eq("http://www.camara.cl/img.aspx?prmid=g939")
        expect(p.memberships.count).to eq(1)
        m = p.memberships.first

        expect(p.other_names.count).to eq(2)
        other_name = p.other_names.first
        expect(other_name.name).to eq('Hasbún S., Gustavo')
        other_name = p.other_names.second
        expect(other_name.name).to eq('Hasbún Selume, Gustavo')
      end
      it "parses other names" do
        p = Popolo::Person.where(:_id => '5330374bd0c05d8b737b6d10').first
        expect(p.other_names.count).to eq(2)
        other_name = p.other_names.first
        expect(other_name.name).to eq('Coloma C., Juan Antonio')
        other_name = p.other_names.second
        expect(other_name.name).to eq('Coloma Correa, Juan Antonio')


      end
      it "doesn't scrape a person twice" do
        @runner.run([])
        p = Popolo::Person.where(:name => "Gabriel Boric Font")
        expect(p.count).to eq(1)
      end
    end
  end
end