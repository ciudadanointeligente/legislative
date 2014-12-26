require 'popolo'
require 'nokogiri'
require 'htmlentities'

module CongresoAbiertoScrapers
	class MotionScrapingRunRecord
		include Mongoid::Document
		field :date, type: Date
	end

	class MotionScraper < Pupa::Processor
		def scrape_motion
			record = MotionScrapingRunRecord.new date:Date.today
			record.save()
			url = 'http://www.senado.cl/wspublico/tramitacion.php?fecha=12%2F12%2F2014'
			doc = open(url).read
			xml_doc  = Nokogiri::XML doc
			xml_doc.css('proyecto').each do |proyecto_|

				proyecto_.css('votaciones').each do |votaciones|
					votaciones.css('votacion').each do |votacion|
						motion = Popolo::Motion.new
						motion.date = Date.strptime votacion.css('FECHA').first.content, '%d/%m/%Y'
						motion.text = votacion.css('TEMA').first.content.strip
						motion.save()
						vote_event = Popolo::VoteEvent.new
						vote_event.motion = motion
						vote_event.save()
						votacion.css('VOTO').each do |voto|
							parlamentario_name = voto.css('PARLAMENTARIO').first.content 
							parlamentario_seleccion = voto.css('SELECCION').first.content
						end
					end
				end
			end

		end
	end
end
CongresoAbiertoScrapers::MotionScraper.add_scraping_task(:motion)
