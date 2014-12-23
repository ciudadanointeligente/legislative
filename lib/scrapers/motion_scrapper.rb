require 'popolo'

module CongresoAbiertoScrapers
	class MotionScrapingRunRecords
		include Mongoid::Document
		field :date, type: Date
	end

	class MotionScraper < Pupa::Processor
		def scrape_motion
			record = MotionScrapingRunRecords.new date:Date.today
			record.save()
		end
	end
end
CongresoAbiertoScrapers::MotionScraper.add_scraping_task(:motion)
