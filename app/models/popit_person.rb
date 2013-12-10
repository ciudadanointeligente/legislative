require 'popit_representers/representers/person_representer'

class PopitPerson < OpenStruct
  include Popit::PersonRepresenter
end
