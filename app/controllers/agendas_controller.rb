require 'json'
require 'rest_client'

class AgendasController < ApplicationController
  before_action :set_agenda, only: [:show, :edit, :update, :destroy]
  
  # GET /agendas
  def index
    @agendas = get_all_the_agendas
    # @agendas = AgendaCollection.new
    # @agendas.get(ENV['tables_url'],'application/json')
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

  # GET all the agendas
  def get_all_the_agendas
    response = RestClient.get(ENV['agendas_url'] + "select%20*%20from%20data%20limit%2020", :content_type => :json, :accept => :json, :"x-api-key" => ENV['morph_io_api_key'])
    response = JSON.parse(response)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agenda
      @agenda = Agenda.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def table_params
      params[:table]
    end
end
