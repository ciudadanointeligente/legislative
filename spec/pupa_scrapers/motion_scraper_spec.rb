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
				text:"Votación enmienda al inc. final del art 27 contenido en la letra c) del número 8 -que pasa a ser 10- del artículo 1º propuesto en el 2º informe del proyecto de ley, en segundo trámite constitucional, que autoriza el levantamiento de secreto bancario en investigaciones de lavado de activos, con segundo y nuevo segundo informe de la Comisión de Constitución, Legislación, Justicia y Reglamento. (discusión en particular). (Boletín N° 4.426-07)."
				)
			expect(motions.count).to  be > 0
			motion = motions.first
			expect(motion.date).to eq(Date.strptime('2014-04-02'))

			
		end
	end
	context "scraping vote events" do
		it "scrapes vote events" do
			runner = Pupa::Runner.new(CongresoAbiertoScrapers::MotionScraper)
			runner.run([])
			motion = Popolo::Motion.where(
				text:'Votación enmienda al inc. final del art 27 contenido en la letra c) del número 8 -que pasa a ser 10- del artículo 1º propuesto en el 2º informe del proyecto de ley, en segundo trámite constitucional, que autoriza el levantamiento de secreto bancario en investigaciones de lavado de activos, con segundo y nuevo segundo informe de la Comisión de Constitución, Legislación, Justicia y Reglamento. (discusión en particular). (Boletín N° 4.426-07).').first

			expect(motion.vote_events.count).to eq(6)
			vote_event = motion.vote_events.where(
				
				)

		end
	end

end