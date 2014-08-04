require 'roar/representer/json/hal'
require 'roar/representer/feature/client'
require 'roar/representer/feature/http_verbs'
require 'writeit-rails'
require 'popit_representers/representers/person_representer'

class LegislativeMessageRepresenter
	include Roar::Representer::JSON::HAL
	include Roar::Representer::Feature::HttpVerbs

	def initialize
		extend Roar::Representer::Feature::Client
		super
	end

	def get(id)
		url = URI.join(ENV['writeit_base_url'], 'api/v1/message/', id.to_s + '/')

		params = URI.encode_www_form("format" => "json",
			"username" => ENV["writeit_username"],
			"api_key" => ENV["writeit_api_key"])
		url.query = params

		super(url.to_s, 'application/json')
	end

	property :subject
	property :content
	# property :recipients
	property :id
	property :author_name
	property :author_email
	property :created
	collection :people, :class => PopitPerson, :extend => Popit::PersonRepresenter
	collection :answers, :class => LegislativeAnswerRepresenter

end