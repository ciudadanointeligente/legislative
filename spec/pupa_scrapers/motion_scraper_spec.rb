require 'spec_helper'
require 'webmock/rspec'
require 'pupa'
require 'popolo'
require './lib/scrapers/motion_scrapper'


WebMock.disable_net_connect!(:allow => /popoloproject.com/)


describe CongresoAbiertoScrapers::MotionScraper , "The Motion Scrapper" do
	before :each do
		$file = File.read('./spec/fixtures/ultimas_tramitaciones.xml')
		stub_request(:get, "http://www.senado.cl/wspublico/tramitacion.php?fecha=12/12/2014").to_return(:body => $file)
	end
	before :all do
		#Add previous records of scraping
		CongresoAbiertoScrapers::MotionScrapingRunRecord.new date:Date.strptime('2014-11-12')
		CongresoAbiertoScrapers::MotionScrapingRunRecord.new date:Date.strptime('2014-12-12')
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
			records = CongresoAbiertoScrapers::MotionScrapingRunRecord.all()
			expect(records.count).to eq(1)
			record = records.first
			expect(record.date).to eq(today)


		end
	end
	context "there are two existing record" do
		before :each do
			
		end
		before :all do
			


		end
		it "creates motions" do
			runner = Pupa::Runner.new(CongresoAbiertoScrapers::MotionScraper)
			runner.run([])
			motions = Popolo::Motion.where(
				date:Date.strptime('2006-08-17'))
			expect(motions.count).to  be > 0
			motion = motions.first
			expect(motion.text).to eq('Autoriza levantamiento de secreto bancario en investigaciones de lavado de activos.')

			
		end
	end

end