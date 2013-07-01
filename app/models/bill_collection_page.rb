require 'billit_representers/representers/bill_collection_page_representer'

class BillCollectionPage < OpenStruct
  include Roar::Representer::Feature::HttpVerbs

  def initialize
    extend Billit::BillCollectionPageRepresenter
    extend Roar::Representer::Feature::Client
    transport_engine = Roar::Representer::Transport::Faraday
  end

  def self
  	links[:self].href if links[:self].href
  end

  def next
  	links[:next].href if links[:next]
  end

  def previous
  	links[:previous].href if links[:previous]
  end
end