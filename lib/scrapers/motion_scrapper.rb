require 'popolo'
require 'nokogiri'
require 'htmlentities'
require 'open-uri'


module CongresoAbiertoScrapers
	class MotionScrapingRunRecord
		include Mongoid::Document
		field :date, type: Date
	end

	class MotionScraper < Pupa::Processor
		def dater
			if @options.include? :dater
				return @options[:dater]
			end
			return Date
		end

		def scrape_motion
			previous_records = MotionScrapingRunRecord.order_by(
				date: 'asc'
				)
			if previous_records.count > 0
				date_encoded = previous_records.last.date.strftime('%d/%m/%Y')
			else
				date_encoded = (self.dater.today.months_ago(1)).strftime('%d/%m/%Y')
			end
			
			record = MotionScrapingRunRecord.new date:self.dater.today
			record.save()
			url = 'http://www.senado.cl/wspublico/tramitacion.php?fecha='+URI::encode(date_encoded)
			doc = open(url).read
			xml_doc  = Nokogiri::XML doc
			xml_doc.css('proyecto').each do |proyecto_|

				proyecto_.css('votaciones').each do |votaciones|
					votaciones.css('votacion').each do |votacion|
						motion = Popolo::Motion.new
						motion.date = self.dater.strptime votacion.css('FECHA').first.content, '%d/%m/%Y'
						motion.text = votacion.css('TEMA').first.content.strip
						motion.save()
						vote_event = Popolo::VoteEvent.new
						vote_event.motion = motion
						vote_event.save()
						votacion.css('VOTO').each do |voto|
							parlamentario_name = voto.css('PARLAMENTARIO').first.content 
							persons = Popolo::Person.where(
								"other_names.name"=>parlamentario_name
								)
							parlamentario_seleccion = voto.css('SELECCION').first.content
							
							if persons.count > 0
								voto = Popolo::Vote.new
								voto.vote_event = vote_event
								voto.option = parlamentario_seleccion
								
								person = persons.first
								person.votes.push voto
								voto.save()
								person.save()
							end
						end
					end
				end
			end

		end
	end
end
CongresoAbiertoScrapers::MotionScraper.add_scraping_task(:motion)
