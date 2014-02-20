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
  end

  # GET /congressmen/new
  def new
    # @congressman = Congressman.new
  end

  # GET /congressmen/1/edit
  def edit
  end

  # POST /congressmen
  def create
    # @congressman = Congressman.new(congressman_params)

    # if @congressman.save
    #   redirect_to @congressman, notice: 'Congressman was successfully created.'
    # else
    #   render action: 'new'
    # end
  end

  # PATCH/PUT /congressmen/1
  def update
    # if @congressman.update(congressman_params)
    #   redirect_to @congressman, notice: 'Congressman was successfully updated.'
    # else
    #   render action: 'edit'
    # end
  end

  # DELETE /congressmen/1
  def destroy
    # @congressman.destroy
    # redirect_to congressmen_url, notice: 'Congressman was successfully destroyed.'
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
