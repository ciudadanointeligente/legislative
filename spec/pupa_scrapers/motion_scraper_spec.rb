require 'spec_helper'
require 'webmock/rspec'
require 'pupa'
require 'popolo'
require './lib/scrapers/motion_scrapper'


WebMock.disable_net_connect!(:allow => /popoloproject.com/)


describe CongresoAbiertoScrapers::MotionScraper , "The Motion Scrapper" do
	before :each do
		CongresoAbiertoScrapers::MotionScrapingRunRecord.all.delete()
		$file = File.read('./spec/fixtures/ultimas_tramitaciones.xml')
		stub_request(:get, "http://www.senado.cl/wspublico/tramitacion.php?fecha=12/12/2014").to_return(:body => $file)
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
			CongresoAbiertoScrapers::MotionScrapingRunRecord.new date:Date.strptime('2014-11-12')
			CongresoAbiertoScrapers::MotionScrapingRunRecord.new date:Date.strptime('2014-12-12')


		end
		it "creates motions" do
			runner = Pupa::Runner.new(CongresoAbiertoScrapers::MotionScraper)
			runner.run([])
			motions = Popolo::Motion.where(
				date:Date.strptime('2007-11-20'))
			expect(motions.count).to  be > 0
			motion = motions.first
			expect(motion.text).to eq('Rechazo letra a) Indicación N°62  , Partida 10 Ministerio de Justicia (Boletín N°8.575-05) Proyecto de Ley de Presupuestos.')
			

		end
		# it "creates one specific one" do
		# 	runner = Pupa::Runner.new(CongresoAbiertoScrapers::MotionScraper)
		# 	runner.run([])
		# 	motions = Popolo::Motion.where(
		# 		text: "Votación para volver a Comisión el proyecto de ley, en segundo trámite constitucional, que fija porcentajes mínimos de emisión de música nacional y música de raíz folklórica oral a la radiodifusión chilena, para un nuevo primer informe de la Comisión de Educación, Cultura, Ciencia y Tecnología. (Boletín N° 5.491-24)."
		# 		)
		# 	expect(motions.count).to eq(1)
		# 	motion = motions.first

		# end
	end
end