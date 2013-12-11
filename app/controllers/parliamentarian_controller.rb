class ParliamentarianController < ApplicationController
  def index
    @parliamentarians = PopitPersonCollection.new
    @parliamentarians.get ENV['popit_persons'], 'application/json'
  end
end
