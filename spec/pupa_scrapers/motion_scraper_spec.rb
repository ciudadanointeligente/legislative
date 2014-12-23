require 'spec_helper'
require 'webmock/rspec'
require 'pupa'
require 'popolo'
require './lib/scrapers/motion_scrapper'


WebMock.disable_net_connect!(:allow => /popoloproject.com/)


describe CongresoAbiertoScrapers::MotionScraper , "The Motion Scrapper" do
	before :each do
		CongresoAbiertoScrapers::MotionScrapingRunRecords.all.delete()
	end
	context "it self" do
		it "initializes" do
			scrapper = CongresoAbiertoScrapers::MotionScraper.new './results'
			expect(scrapper).to be_a Pupa::Processor
		end
	end
	context "recording every run" do
		let!(:today) { Date.strptime('2014-12-12') }
		before do
		  Date.stub(:today).and_return(today)
		end

		it "records every run" do
			runner = Pupa::Runner.new(CongresoAbiertoScrapers::MotionScraper)
			runner.run([])
			records = CongresoAbiertoScrapers::MotionScrapingRunRecords.all()
			expect(records.count).to eq(1)
			record = records.first
			expect(record.date).to eq(today)


		end
	end
end