require 'roar/representer/json'
require 'roar/representer/feature/hypermedia'

module Billit
  module BillRepresenter
    include Roar::Representer::JSON::HAL

    property :uid
    property :title
    property :summary
    property :tags
    property :matters
    property :stage
    property :creation_date
    property :publish_date
    property :authors
    property :origin_chamber
    property :current_urgency
    property :table_history
    property :link_law

    property :events
    property :urgencies
    property :reports

    link :self do
      bill_url(self.uid)
    end
  end
end
