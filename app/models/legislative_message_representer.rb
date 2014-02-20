require 'roar/representer/json/hal'
require 'roar/representer/feature/client'
require 'roar/representer/feature/http_verbs'
require 'writeit-rails'

class LegislativeMessageRepresenter
		include Roar::Representer::JSON::HAL
	include Roar::Representer::Feature::HttpVerbs
	
	def initialize
		extend Roar::Representer::Feature::Client
		super
	end

	property :subject
	property :content
	# property :recipients
	property :remote_id
	property :author_name
	property :author_email
end