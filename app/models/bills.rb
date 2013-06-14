require 'roar/representer/feature/client'
require 'billit_representers/representers/bills_representer'

class Bills < OpenStruct
  include Roar::Representer::Feature::HttpVerbs

  def initialize
    extend Billit::BillsRepresenter
    extend Roar::Representer::Feature::Client
    transport_engine = Roar::Representer::Transport::Faraday
  end
end
