require 'roar/representer/feature/client'
require 'billit_representers/representers/bill_collection_representer'

class BillCollection < OpenStruct
  include Roar::Representer::Feature::HttpVerbs

  def initialize
    extend Billit::BillCollectionRepresenter
    extend Roar::Representer::Feature::Client
    transport_engine = Roar::Representer::Transport::Faraday
  end
end
