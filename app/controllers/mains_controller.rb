class MainsController < ApplicationController

  # GET /mains
  def index
    @condition_search = true
    @condition_priority_box = true
    @high_chamber_agendas = get_high_chamber_agenda
    @low_chamber_agendas = get_low_chamber_agenda
  end

  # GET the high chamber agenda
  def get_high_chamber_agenda
    response = RestClient.get(ENV['agendas_url'] + "select%20*%20from%20data%20where%20chamber%20%3D%20'Senado'%20limit%204", :content_type => :json, :accept => :json, :"x-api-key" => ENV['morph_io_api_key'])
    response = JSON.parse(response)
  end

  # GET the low chamber agenda
  def get_low_chamber_agenda
    response = RestClient.get(ENV['agendas_url'] + "select%20*%20from%20data%20where%20chamber%20%3D%20'C.Diputados'%20limit%204", :content_type => :json, :accept => :json, :"x-api-key" => ENV['morph_io_api_key'])
    response = JSON.parse(response)
  end
end
