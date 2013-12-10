class CommunicationController < ApplicationController
  def index
    @persons = PopitPerson.new
    # [fix] - improbe the ENV url for popit, actually works without http in some instances
    @persons.get('http://'+ENV['popit']+'/api/v0.1/persons/500804717a317e126400005e','application/json')
  end
end
