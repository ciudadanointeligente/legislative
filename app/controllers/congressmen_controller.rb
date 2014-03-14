require 'popit_representers/models/organization_collection'
require './app/models/bill'
require 'billit_representers/models/bill_page'
require 'RMagick'
require "open-uri"

class CongressmenController < ApplicationController

  # GET /congressmen
  def index
    # @congressmen = PopitPersonCollection.new
    # @congressmen.get ENV['popit_persons']+'?page='+"#{params[:page]}", 'application/json'
    
    @title = t('congressmen.title') + ' - '

    # Very, very ugly code, sorry. Impossible (yet) obtains all the persons ordered by name in Popit, and the per_page param is fixed
    @congressmenFirstBatch = PopitPersonCollection.new
    @congressmenSecondBatch = PopitPersonCollection.new
    @congressmenTotal = Array.new

    @congressmenFirstBatch.get ENV['popit_persons']+'?per_page=100&page=1', 'application/json'
    @congressmenSecondBatch.get ENV['popit_persons']+'?per_page=100&page=2', 'application/json'
    @congressmen = @congressmenFirstBatch.persons + @congressmenSecondBatch.persons
    @congressmen.sort! { |x,y| x.name <=> y.name }
  end

  # GET /congressmen/1
  def show
    @congressman = PopitPerson.new
    @congressman.get ENV['popit_persons']+params[:id]+'?include_root=false', 'application/json'

    @bills = (Billit::BillCollectionPage.get ENV['billit_url']+'search.json?authors='+URI::escape(@congressman.name)+ '&per_page=3', 'application/json').bills

    @organizations = Popit::OrganizationCollection.new
    @organizations.get ENV['popit_organizations'], 'application/json'

    #setup the title page
    @title = @congressman.name + " - "

    @el_twitter = ''
    @congressman.enlaces.each do | link |
      case link.note.downcase
      when 'twitter'
        @el_twitter = URI(link.url).path.sub! '/', '@'
      end
    end
    
    messages = LegislativeMessageCollection.new
    messages.get(person: @congressman)
    @message = messages.objects[0]
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
      param_q = URI::escape(params[:q])
      @congressmen.get ENV['popit_search']+"q="+param_q, 'application/json'
    else
      @congressmen.get ENV['popit_search'], 'application/json'
    end
    @title = t('congressmen.title_search') + ' - '
  end
end
