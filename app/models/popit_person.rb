require 'popit_representers/representers/person_representer'

class PopitPerson < OpenStruct
  include Popit::PersonRepresenter
  def popit_web_url
    url = 'http://' + ENV['popit_url']+ '/persons/' + slug
    return url
  end
end
