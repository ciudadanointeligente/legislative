require 'popit_representers/models/organization_collection'
require 'billit_representers/models/bill_page'
require './app/models/bill'
require './app/models/bill_basic'
require 'RMagick'
require 'open-uri'
require 'popolo'

class CongressmenController < ApplicationController
  caches_page :index, :show

  # GET /congressmen
  def index
    @congressmen =  Hash.new
    @organizations = Hash.new

    if !ENV['popit_url'].blank? and !ENV['popit_persons'].blank? and !ENV['popit_search'].blank? and !ENV['popit_organizations'].blank? and !ENV['popit_organizations_search'].blank?
      @congressmen = PopitPersonCollection.new
      begin
        RestClient.get ENV['popit_persons']
        @congressmen.get ENV['popit_persons']+'?per_page=200', 'application/json'
        @congressmen.persons.sort! { |x,y| x.name <=> y.name }

        @organizations = get_organizations
      rescue => e
        @message = e.response
      end
      
    end
    @title = t('congressmen.title') + ' - '
  end


  # GET /congressmen/votes/1
  def votes 
    
    get_popolo_person
  end

  # GET /congressmen/1
  def show
    @congressmen =  Hash.new
    @organizations = Hash.new
    @message = Hash.new

    get_popolo_person


    if !ENV['billit_url'].blank? and !ENV['popit_url'].blank? and !ENV['popit_persons'].blank? and !ENV['popit_search'].blank? and !ENV['popit_organizations'].blank? and !ENV['popit_organizations_search'].blank?
      @congressman = PopitPerson.new
      @congressman.get ENV['popit_persons']+params[:id]+'?include_root=false', 'application/json'

      if !@congressman.name.blank?
        @bills = (Billit::BillPage.get ENV['billit_url']+'search.json?authors='+URI::escape(@congressman.name)+ '&per_page=3', 'application/json').bills

        @organizations = get_organizations

        #setup the title page
        @title = @congressman.name + " - "

        @el_twitter = ''
        @congressman.links.each do | link |
          case link.note.downcase
          when 'twitter'
            @el_twitter = URI(link.url).path.sub! '/', '@'
          end
        end

        @district = ''
        @region = ''
        @congressman.represent.each do | r |
          if ! r.district.blank?
            @district = r.district
          end
          if ! r.region.blank?
            @region = r.region
          end
        end
        
        if !ENV['writeit_base_url'].blank? and !ENV['writeit_url'].blank? and !ENV["writeit_username"].blank? and !ENV["writeit_api_key"].blank? and !ENV["writeit_messages_per_page"].blank?
          messages = LegislativeMessageCollection.new
          messages.get(person: @congressman)
          @message = messages.objects[0]
        end
      else
        flash[:notice] = t('bill.bill_dont_exist')
        redirect_to url_for :controller => 'congressmen', :action => 'searches'
      end
    end
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
    if !ENV['popit_organizations'].blank?
      @organizations = get_organizations

      @title = t('congressmen.title_search') + ' - '

      if !params.nil? && params.length > 3
        keywords = Hash.new
        params.each do |key, value|
          if key != 'utf8' && key != 'congressmen' && key != 'locale' && key != 'format' && key != 'controller' && key != 'action'
            keywords.merge!(key => value)
          end
        end
        keywords.delete_if { |k, v| v.empty? }
      else
      end
      get_author_results keywords
    end
  end

  # GET organizations from Popit
  def get_organizations
    organizations = Popit::OrganizationCollection.new
    organizations.get ENV['popit_organizations'], 'application/json'
    organizations = organizations.result.sort! { |x,y| x.name <=> y.name }
    return organizations
  end

  # GET authors from congressmen helper in morph.io
  def get_author_results keywords
    if !keywords.blank?
      query_keywords = "WHERE "
      keywords.each_with_index do |param, index|
        if param[0] == 'zone'
          query_keywords << 'region LIKE "%' + param[1] + '%" OR commune LIKE "%' + param[1] + '%"'
        elsif param[0] == 'q'
          query_keywords << 'name LIKE "%' + param[1] + '%"'
        elsif param[0] == 'organizations'
          query_keywords << "organization_id LIKE '%" + param[1] + "%'"
        else
          query_keywords << param[0] + ' LIKE "%' + param[1] + '%"'
        end
        if index < keywords.size - 1
          query_keywords << ' AND '
        end
      end
    else
      query_keywords = ""
    end

    if !ENV['congressmen_helper_url'].blank? and !ENV['morph_io_api_key'].blank?
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
          @congressmen.persons.sort! { |x,y| x.name <=> y.name }
        end
      end
    end

  end


  private
  def get_popolo_person
    possible_persons = Popolo::Person.where(:id =>params[:id] )
    if possible_persons.length > 0
      @popolo_person = possible_persons.first
    end
  end
end
