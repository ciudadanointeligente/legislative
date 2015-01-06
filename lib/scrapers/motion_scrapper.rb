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
                previous_record = previous_records.last.date
                date_encoded = previous_record.strftime('%d/%m/%Y')
            else
                previous_record = self.dater.today.months_ago(1)
                date_encoded = (previous_record).strftime('%d/%m/%Y')
            end
            
            record = MotionScrapingRunRecord.new date:self.dater.today
            record.save()
            url = 'http://www.senado.cl/wspublico/tramitacion.php?fecha='+URI::encode(date_encoded)
            doc = open(url).read
            xml_doc  = Nokogiri::XML doc
            persons_without_votes = []
            xml_doc.css('proyecto').each do |proyecto_|
                boletin = proyecto_.css('descripcion/boletin').first.content.strip
                
                proyecto_.css('votaciones').each do |votaciones|
                    votaciones.css('votacion').each do |votacion|
                        motion = Popolo::Motion.new
                        motion.date = self.dater.strptime votacion.css('FECHA').first.content, '%d/%m/%Y'
                        motion.identifier = boletin
                        motion.text = votacion.css('TEMA').first.content.strip
                        motion.save()
                        vote_event = Popolo::VoteEvent.new
                        vote_event.motion = motion
                        vote_event.save()

                        get_votaciones_diputados_por_boletin(boletin, vote_event, previous_record)

                        votacion.css('VOTO').each do |voto|
                            parlamentario_name = voto.css('PARLAMENTARIO').first.content.strip
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
                            else
                                if persons_without_votes.include? parlamentario_name
                                    persons_without_votes.push(parlamentario_name)
                                end
                                
                            end
                        end
                    end
                end
            end
            puts "People that we could not find"
            persons_without_votes.each do |parlamentario_name|
                puts parlamentario_name
            end


        end

        def get_votaciones_diputados_por_boletin(boletin, vote_event, previous_record)
            url = 'http://opendata.congreso.cl/wscamaradiputados.asmx/getVotaciones_Boletin?prmBoletin='+URI::encode(boletin)
            doc = open(url).read

            xml_doc  = Nokogiri::XML doc
            xml_doc.css('Votaciones/Votacion').each do |votacion|
                date = Date.strptime votacion.css('Fecha').first.content.strip
                if date >= previous_record
                    votacion_id = votacion.css('ID').first.content.strip

                    url2 = 'http://opendata.congreso.cl/wscamaradiputados.asmx/getVotacion_Detalle?prmVotacionID='+URI::encode(votacion_id)
                    doc2 = open(url2).read
                    xml_doc2  = Nokogiri::XML doc2
                    xml_doc2.css('Votacion/Votos/Voto').each do |voto|
                        nombre = voto.css('Nombre').first.content.strip
                        apellido_paterno = voto.css('Apellido_Paterno').first.content.strip
                        apellido_materno = voto.css('Apellido_Materno').first.content.strip
                        nombre_completo = nombre + " " + apellido_paterno + " " + apellido_materno
                        if Popolo::Person.where(name: nombre_completo).count > 0
                            person = Popolo::Person.where(name: nombre_completo).first
                            voto = Popolo::Vote.new
                            voto.vote_event = vote_event
                            voto.save
                            person.votes.push voto

                        end

                    end

                end
            end
        end
    end
end
CongresoAbiertoScrapers::MotionScraper.add_scraping_task(:motion)


## Esta wea funciona de esta manera
## require './lib/scrapers/motion_scrapper'
## runner = Pupa::Runner.new(CongresoAbiertoScrapers::MotionScraper)
## runner.run([])
