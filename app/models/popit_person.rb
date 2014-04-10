require 'popit_representers/representers/person_representer'
require 'multi_json'

class PopitPerson < OpenStruct
  include Popit::PersonRepresenter
  def popit_api_uri
    url = ENV['popit_persons']+ id.to_s
    return url
  end

  def from_json(data, options = {})	
  	data_hash = MultiJson.load(data)
  	if data_hash.has_key?("result")
  		data = data_hash['result'].to_json
  	end
  	super(data, options)
  end
end
