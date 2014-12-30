require 'spec_helper'
require 'webmock/rspec'
require 'pupa'
require 'popolo'
require './lib/scrapers/motion_scrapper'


WebMock.disable_net_connect!(:allow => /popoloproject.com/)


describe CongresoAbiertoScrapers::MotionScraper , "The Motion Scrapper" do
	before :each do
		$file = File.read('./spec/fixtures/ultimas_tramitaciones.xml')
		
	end
	
	context "it self" do
		before :each do
			CongresoAbiertoScrapers::MotionScrapingRunRecord.create date:Date.strptime('2014-11-12')
			CongresoAbiertoScrapers::MotionScrapingRunRecord.create date:Date.strptime('2014-12-12')
			stub_request(:get, "http://www.senado.cl/wspublico/tramitacion.php?fecha=12/12/2014").to_return(:body => $file)
		end
		before :all do
			#Add previous records of scraping
			
		end
		it "initializes" do
			scrapper = CongresoAbiertoScrapers::MotionScraper.new './results'
			expect(scrapper).to be_a Pupa::Processor
		end
	end
	context "recording every run" do
		before :each do
			CongresoAbiertoScrapers::MotionScrapingRunRecord.create date:Date.strptime('2014-11-12')
			stub_request(:get, "http://www.senado.cl/wspublico/tramitacion.php?fecha=12/11/2014").to_return(:body => $file)
		end
		before :all do
			#Add previous records of scraping
			
			
		end
		let!(:today) { Date.strptime('2014-12-12') }
		before do
		  
		end

		it "records every run" do

			Date.stub(:today).and_return(today)
			runner = Pupa::Runner.new(CongresoAbiertoScrapers::MotionScraper)
			runner.run([:level => "ERROR"])
			records = CongresoAbiertoScrapers::MotionScrapingRunRecord.all()
			expect(records.count).to eq(2)
			record = records.order_by(:date=>'asc').last
			expect(record.date).to eq(today)


		end
	end
	context "scraping dayly" do
		it "records according to a day" do
			CongresoAbiertoScrapers::MotionScrapingRunRecord.create date:Date.strptime('2014-11-12')
			CongresoAbiertoScrapers::MotionScrapingRunRecord.create date:Date.strptime('2014-12-12')
			today__ = Date.strptime('2014-12-20')
			date_spy = class_spy("Date")
			allow(date_spy).to receive(:today) { today__ }



			stub__ = stub_request(:get, "http://www.senado.cl/wspublico/tramitacion.php?fecha=12/12/2014").to_return(:body => "")

			scraper_class = CongresoAbiertoScrapers::MotionScraper

			runner = Pupa::Runner.new(scraper_class)
			runner.run([
				:dater => date_spy,
				:level => "ERROR"
				])
			records = CongresoAbiertoScrapers::MotionScrapingRunRecord.where(
				:date => today__
				)
			expect(records.count).to eq(1)
			record = records.first
			expect(record.date).to eq(today__)

		end
		it "scrapes when there are no records" do
			today__ = Date.strptime('2014-12-20')
			date_spy = class_spy("Date")
			allow(date_spy).to receive(:today) { today__ }



			stub__ = stub_request(:get, "http://www.senado.cl/wspublico/tramitacion.php?fecha=20/11/2014").to_return(:body => "")

			scraper_class = CongresoAbiertoScrapers::MotionScraper

			runner = Pupa::Runner.new(scraper_class)
			runner.run([
				:dater => date_spy,
				:level => "ERROR"
				])
			records = CongresoAbiertoScrapers::MotionScrapingRunRecord.where(
				:date => today__
				)
			expect(records.count).to eq(1)
			record = records.first
			expect(record.date).to eq(today__)			
		end
	end
	context "there are two existing record" do
		before :each do
			CongresoAbiertoScrapers::MotionScrapingRunRecord.create date:Date.strptime('2014-11-12')
			CongresoAbiertoScrapers::MotionScrapingRunRecord.create date:Date.strptime('2014-12-12')
			stub_request(:get, "http://www.senado.cl/wspublico/tramitacion.php?fecha=12/12/2014").to_return(:body => $file)
		end
		before :all do
			#Add previous records of scraping
			
		end
		it "creates motions" do
			runner = Pupa::Runner.new(CongresoAbiertoScrapers::MotionScraper)
			runner.run([:level => "ERROR"])
			motions = Popolo::Motion.where(
				text:"Votación enmienda al inc. final del art 27 contenido en la letra c) del número 8 -que pasa a ser 10- del artículo 1º propuesto en el 2º informe del proyecto de ley, en segundo trámite constitucional, que autoriza el levantamiento de secreto bancario en investigaciones de lavado de activos, con segundo y nuevo segundo informe de la Comisión de Constitución, Legislación, Justicia y Reglamento. (discusión en particular). (Boletín N° 4.426-07)."
				)
			expect(motions.count).to  be > 0
			motion = motions.first
			expect(motion.date).to eq(Date.strptime('2014-04-02'))
			expect(motion.identifier).to eq('4426-07')

			
		end
	end
	context "scraping vote events" do
		before :each do
			CongresoAbiertoScrapers::MotionScrapingRunRecord.create date:Date.strptime('2014-12-12')
			CongresoAbiertoScrapers::MotionScrapingRunRecord.create date:Date.strptime('2014-11-12')
			stub_request(:get, "http://www.senado.cl/wspublico/tramitacion.php?fecha=12/12/2014").to_return(:body => $file)
		end
		before :all do
			#Add previous records of scraping
		end
		it "scrapes vote events" do
			# {
			# 	"_id" : ObjectId("53303746d0c05d8b737b6cff"),
			# 	"birth_date" : "1955-05-22",
			# 	"created_at" : ISODate("2014-12-22T15:41:06.497Z"),
			# 	"honorific_prefix" : "Senador",
			# 	"image" : "http://www.senado.cl/appsenado/index.php?mo=senadores&ac=getFoto&id=690&tipo=1",
			# 	"name" : "José García Ruminot",
			# 	"other_names" : [
			# 		{
			# 			"_id" : ObjectId("54988cf37061722527820000"),
			# 			"name" : "García R., José"
			# 		}
			# 	],
			# 	"updated_at" : ISODate("2014-12-22T20:36:00.859Z")
			# }
			person = Popolo::Person.create name:"José García Ruminot", id:"53303746d0c05d8b737b6cff"
			person.other_names.push Popolo::OtherName.new name: "García R., José"
			person.save

			runner = Pupa::Runner.new(CongresoAbiertoScrapers::MotionScraper)
			runner.run([:level => "ERROR"])
			motion = Popolo::Motion.where(
				text:'Votación enmienda al inc. final del art 27 contenido en la letra c) del número 8 -que pasa a ser 10- del artículo 1º propuesto en el 2º informe del proyecto de ley, en segundo trámite constitucional, que autoriza el levantamiento de secreto bancario en investigaciones de lavado de activos, con segundo y nuevo segundo informe de la Comisión de Constitución, Legislación, Justicia y Reglamento. (discusión en particular). (Boletín N° 4.426-07).').first

			expect(motion.vote_events.count).to eq(1)
			vote_event = motion.vote_events.first
			votos = vote_event.votes.all()
			voto = votos.first

			expect(voto).to_not be_nil
			expect(voto.voter._id).to eq(person.id)
			expect(voto.voter.id).to eq(person.id)
		end
	end

end