class CommunicationController < ApplicationController
  def index
    @persons = PopitPerson.new
    @persons.get(ENV['popit']+'api/v0.1/persons/500804717a317e126400005e','application/json')
  end
end
