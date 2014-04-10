require 'popit_representers/models/organization_collection'
require 'billit_representers/models/bill_page'
require './app/models/bill'
require 'RMagick'
require 'open-uri'

class CongressmenController < ApplicationController
  caches_page :index, :show

  # GET /congressmen
  def index
    # @congressmen = PopitPersonCollection.new
    # @congressmen.get ENV['popit_persons']+'?page='+"#{params[:page]}", 'application/json'
    
    @title = t('congressmen.title') + ' - '

    @congressmen = PopitPersonCollection.new
    @congressmen.get ENV['popit_persons']+'?per_page=200', 'application/json'
    @congressmen.persons.sort! { |x,y| x.name <=> y.name }

    organizations = Popit::OrganizationCollection.new
    organizations.get ENV['popit_organizations'], 'application/json'
    @organizations = organizations.result
  end

  # GET /congressmen/1
  def show
    @congressman = PopitPerson.new
    @congressman.get ENV['popit_persons']+params[:id]+'?include_root=false', 'application/json'

    @bills = (Billit::BillPage.get ENV['billit_url']+'search.json?authors='+URI::escape(@congressman.name)+ '&per_page=3', 'application/json').bills

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
    # @congressmen = PopitPersonCollection.new
    # if !params.nil? && params.length > 3
    #   param_q = URI::escape(params[:q])
    #   @congressmen.get ENV['popit_search']+"q="+param_q, 'application/json'
    # else
    #   @congressmen.get ENV['popit_search'], 'application/json'
    # end

    organizations = Popit::OrganizationCollection.new
    organizations.get ENV['popit_organizations'], 'application/json'
    @organizations = organizations.result

    @title = t('congressmen.title_search') + ' - '

    if !params.nil? && params.length > 3
      keywords = Hash.new
      params.each do |key, value|
        if key != 'utf8' && key != 'congressmen' && key != 'locale' && key != 'format' && key != 'controller' && key != 'action'
          keywords.merge!(key => value)
        end
      end
    else
    end
    get_author_results keywords
  end

  # GET authors from congressmen helper in morph.io
  def get_author_results keywords
    if !keywords.blank?
      query_keywords = "WHERE "
      keywords.each_with_index do |param, index|
        if param[0] == 'zone'
          query_keywords << "region LIKE '%" + param[1] + "%' OR commune LIKE '%" + param[1] + "%'"
        else
          query_keywords << param[0] + " LIKE '%" + param[1] + "%'"
        end
        if index < keywords.size - 1
          query_keywords << ' AND '
        end
      end
    else
      query_keywords = ""
    end

    query = sprintf("select * from data %s limit 200", I18n.transliterate(query_keywords))
    query = URI::escape(query)
    response = RestClient.get(ENV['congressmen_helper_url'] + query, :content_type => :json, :accept => :json, :"x-api-key" => ENV['morph_io_api_key'])
    response = JSON.parse(response)
    @congressmen = PopitPersonCollection.new
    @congressmen.result = Array.new
    if !response.blank?
      response.each do |congressman|
        record = PopitPerson.new
        record.id = congressman["uid"]
        record.name = congressman["name"]
        record.title = congressman["chamber"]
        record.images = Array.new
        record.images[0] = Popit::Personimage.new
        record.images[0].url = congressman["profile_image"]
        record.represent = Array.new
        record.represent[0] = Popit::Personrepresent.new
        record.represent[0].region = congressman["region"]

        @congressmen.persons.push record
      end
    end
  end
end
