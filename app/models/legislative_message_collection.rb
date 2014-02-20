require 'roar/representer'
require 'roar/representer/feature/client'
require 'roar/representer/feature/http_verbs'
require 'roar/representer/json/hal'

# class Meta
# 	include Roar::Representer
# 	include Roar::Representer::JSON::HAL

# 	property :limit
# 	property :next
# 	property :offset
# 	property :previous
# 	property :total_count
# end

class LegislativeMessageCollection
	include Roar::Representer
	include Roar::Representer::JSON::HAL
	include Roar::Representer::Feature::HttpVerbs

	def initialize
		extend Roar::Representer::Feature::Client
		super
	end

	collection :objects, :class => LegislativeMessageRepresenter

	property :meta

	def get
		
		url = URI.join(ENV['writeit_base_url'], ENV['writeit_url'], 'messages/')
		params = URI.encode_www_form("format" => "json", 
			"username" => ENV["writeit_username"], 
			"api_key" => ENV["writeit_api_key"], 
			"limit" => ENV["writeit_messages_per_page"])
		url.query = params
		super(url.to_s, 'application/json')
	end
end