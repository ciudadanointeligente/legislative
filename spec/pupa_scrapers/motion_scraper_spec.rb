require 'spec_helper'
require 'webmock/rspec'
require 'pupa'
require 'popolo'
require './lib/scrapers/motion_scrapper'


WebMock.disable_net_connect!(:allow => /popoloproject.com/)
# WebMock.disable_net_connect!(:allow => /opendata.congreso.cl/)
possible_bill_ids = ["4162-07","4426-07","4599-07","5491-24","5857-13","6110-24","6201-02","6422-07","6499-11","6556-10","6562-07","6829-01","7011-07","7130-07","7523-24","7550-06","7765-07","7873-07","7908-15","8026-11","8049-17","8069-14","8132-26","8182-10","8207-07","8239-07","8263-13","8307-15","8335-24","8480-03","8624-07","8668-04","8784-04","8805-07","8810-07","8859-04","8886-11","8980-06","9057-04","9097-21","9099-24","9109-02","9126-13","9151-21","9252-15","9276-07","9287-06","9326-07","9333-04","9336-25","9337-16","9365-04","9366-04","9372-07","9386-13","9398-04","9402-13","9404-12","9405-04","9407-14","9430-06","9464-10","9481-04","9484-15","9507-06","9514-07","9515-08","9529-07","9557-04","9566-29","9596-06","9597-07","9608-07","9624-08","9628-08","9669-07","9683-12","9690-01","9691-06","9692-07","9707-02","9715-07","9766-04","9777-06","9780-07","9781-16","9782-16","9783-14","9784-07","9785-14","9786-07","9787-07","9788-07","9789-13","9790-07","9791-05","9792-03","9793-05","9794-06","9795-07","9796-07","9797-07","9798-11","9799-12","9800-12","9801-15","9802-12","9803-03","9804-03","9805-04","9806-06","9807-07","9808-07","9809-17","9810-01","9811-03","9812-03","9813-07","9814-11","9815-15","9816-15","9817-15","9818-17","9819-24","9820-07","9821-03","9822-07","9823-07","9824-17"]
possible_vote_event_id = ["20456","20455","20467","20459","20451","20453","20452","20454","20458","20457","20461","20466","20462","20468","20460"]

describe CongresoAbiertoScrapers::MotionScraper , "The Motion Scrapper" do
	before :each do
		$file = File.read('./spec/fixtures/ultimas_tramitaciones.xml')
		stub_request(:get, "http://opendata.congreso.cl/wscamaradiputados.asmx/getVotaciones_Boletin?prmBoletin=4162-07")
			.to_return(:body => "<Votaciones />")

		possible_bill_ids.each do |bill_id|
			get_votaciones_boletin3 = File.read('./spec/fixtures/votaciones_camara_boletin/'+bill_id+'.xml')
			stub_request(:get, "http://opendata.congreso.cl/wscamaradiputados.asmx/getVotaciones_Boletin?prmBoletin="+bill_id)
				.to_return(:body => get_votaciones_boletin3)
		end
		possible_vote_event_id.each do |vote_event_id|
			get_votaciones_boletin3 = File.read('./spec/fixtures/votaciones_camara_boletin/votacion_'+vote_event_id+'.xml')
			stub_request(:get, "http://opendata.congreso.cl/wscamaradiputados.asmx/getVotacion_Detalle?prmVotacionID="+vote_event_id)
				.to_return(:body => get_votaciones_boletin3)
		end
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
			stub_request(:get, /www.senado.cl/)
			stub_request(:get, /opendata.congreso.cl/)
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
		it "va a la camara a buscar cosas" do
			person = Popolo::Person.create name:"Marco Antonio Núñez Lozano", id:"5330375fd0c05d8b737b6d61"
			person.save

			runner = Pupa::Runner.new(CongresoAbiertoScrapers::MotionScraper)
			runner.run([:level => "ERROR"])

			motion = Popolo::Motion.where(
				text:"Aprobación en general del proyecto de ley, en segundo trámite constitucional, que modifica la ley N° 17.798, de Control de Armas, y el Código Procesal Penal, con informe de la Comisión de Defensa Nacional (Boletín N° 6.201-02).").first

			vote_event = motion.vote_events.first
			votos = vote_event.votes.where(
				voter:person)
			expect(votos.count).to be > 0
			expect(votos.first.voter.id).to eq(person.id)
		end
	end

end