require 'popit_representers/models/organization_collection'

class CongressmenController < ApplicationController

  # GET /congressmen
  def index
    @congressmen = PopitPersonCollection.new
    @congressmen.get ENV['popit_persons'], 'application/json'
  end

  # GET /congressmen/1
  def show
    @congressmen = PopitPersonCollection.new
    @congressmen.get ENV['popit_persons'], 'application/json'

    @organizations = Popit::OrganizationCollection.new
    @organizations.get ENV['popit_organizations'], 'application/json'

    @congressmen.result.each do |congressman|
      @congressman = congressman if congressman.id == params[:id]
    end
    messages = LegislativeMessageCollection.new
    messages.get(person: @congressman)
    @message = messages.objects[0]

    #setup the title page
    @title = @congressman.name + " - "
  end

  # GET /congressmen/new
  def new
  end

  # GET /congressmen/1/edit
  def edit
  end

  # POST /congressmen
  def create
  end

  # PATCH/PUT /congressmen/1
  def update
  end

  # DELETE /congressmen/1
  def destroy
  end

  def searches
    @congressmen = PopitPersonCollection.new
    if !params.nil? && params.length > 3
      @congressmen.get ENV['popit_search']+"q="+params[:q], 'application/json'
    else
      @congressmen.get ENV['popit_search'], 'application/json'
    end
  end
end
