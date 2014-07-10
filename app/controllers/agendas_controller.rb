require 'json'
require 'rest_client'

class AgendasController < ApplicationController
  before_action :set_table, only: [:show, :edit, :update, :destroy]
  caches_page :index
  
  # GET /agendas
  def index
    @title = t('agendas.title') + ' - '
    @events = (agendas_table + district_weeks).to_json
  end

  # GET /agendas/1
  def show
  end

  # GET /agendas/new
  def new
    # @agenda = Agenda.new
  end

  # GET /agendas/1/edit
  def edit
  end

  # POST /agendas
  def create
    # @agenda = Agenda.new(table_params)

    # if @agenda.save
    #   redirect_to @agenda, notice: 'Table was successfully created.'
    # else
    #   render action: 'new'
    # end
  end

  # PATCH/PUT /agendas/1
  def update
    # if @agenda.update(table_params)
    #   redirect_to @agenda, notice: 'Table was successfully updated.'
    # else
    #   render action: 'edit'
    # end
  end

  # DELETE /agendas/1
  def destroy
    # @agenda.destroy
    redirect_to tables_url, notice: 'Table was successfully destroyed.'
  end

  # GET agendas event
  def agendas_table
    query = 'select * from data limit 200'
    query = URI::escape(query)
    response = RestClient.get(ENV['agendas_url'] + query, :content_type => :json, :accept => :json, :"x-api-key" => ENV['morph_io_api_key'])
    @raw_agendas = JSON.parse(response)

    event_agendas = Array.new
    @raw_agendas.each_with_index do |table, index|
      event_agendas[index] = Hash.new
      event_agendas[index]['title'] = 'Tabla de sesión, legislatura ' + table['legislature'] + ' sesión nro. ' + table['session'] + ' (' + table['chamber'] + ')'
      event_agendas[index]['start'] = table['date']
      event_agendas[index]['backgroundColor'] = '#a6a691'
      event_agendas[index]['borderColor'] = '#b3b3a4'
    end
    return event_agendas
  end

  # GET district weeks event
  def district_weeks
    query = 'select * from data limit 200'
    query = URI::escape(query)
    response = RestClient.get(ENV['district_weeks_url'] + query, :content_type => :json, :accept => :json, :"x-api-key" => ENV['morph_io_api_key'])
    event_district_weeks = JSON.parse(response)

    event_district_weeks.each do |district_week|
      district_week.delete('chamber')
      district_week.delete('url')
      district_week.delete('date_scraped')
      district_week['backgroundColor'] = '#b99eaf'
      district_week['borderColor'] = '#b3b3a4'
    end
    return event_district_weeks
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_table
      @agenda = Table.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def table_params
      params[:table]
    end
end
