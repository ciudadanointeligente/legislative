require 'roar/representer'
require 'roar/representer/feature/client'
require 'roar/representer/feature/http_verbs'
require 'roar/representer/json/hal'

class LegislativeMessageCollection
	include Roar::Representer
	include Roar::Representer::JSON::HAL
	include Roar::Representer::Feature::HttpVerbs

	def initialize
		extend Roar::Representer::Feature::Client
		super
	end

	collection :objects, :class => LegislativeMessageRepresenter
	def get_all
		
	end
end