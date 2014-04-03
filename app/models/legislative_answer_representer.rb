require 'roar/representer/json/hal'
require 'roar/representer/feature/client'
require 'roar/representer/feature/http_verbs'
require 'writeit-rails'

class LegislativeAnswerRepresenter
  include Roar::Representer::JSON::HAL
  include Roar::Representer::Feature::HttpVerbs

  def initialize
    extend Roar::Representer::Feature::Client
    super
  end

  def from_json(document,options={})
    super
    self.created = Date.parse(self.created)
  end

  property :id
  property :content
  property :created
  property :message_id
  property :person, :class => PopitPerson, :extend => Popit::PersonRepresenter
end
