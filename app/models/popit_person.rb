require 'popit_representers/representers/person_representer'

class PopitPerson < OpenStruct
  include Popit::PersonRepresenter
  def popit_api_uri
    url = ENV['popit_persons']+ id
    return url
  end
end
