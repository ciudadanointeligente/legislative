class CommunicationsController < ApplicationController
  # GET /communications
  def index
    @parliamentarians = PopitPersonCollection.new
    @parliamentarians.get ENV['popit_persons'], 'application/json'
    # [fix] - improbe the ENV url for popit, actually works without http in some instances
  end
end
