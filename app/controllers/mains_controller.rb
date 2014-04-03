require 'billit_representers/models/bill_page'

class MainsController < ApplicationController

  # GET /mains
  def index
    @condition_search = true
    @condition_priority_box = true
    @social_network_box = true
    @low_chamber_agenda = Array.new
    @high_chamber_agenda = Array.new

    @low_chamber_agenda[0] = get_current_chamber_agenda ENV['low_chamber_name']
    @low_chamber_agenda[1] = get_bills_per_agenda JSON.parse(@low_chamber_agenda[0]['bill_list']).uniq

    @high_chamber_agenda[0] = get_current_chamber_agenda ENV['high_chamber_name']
    @high_chamber_agenda[1] = get_bills_per_agenda JSON.parse(@high_chamber_agenda[0]['bill_list']).uniq

    @hot_bills = Billit::BillCollectionPage.get(ENV['billit_url'] + "search?current_urgency=Simple&per_page=8", 'application/json').bills

    @answers = LegislativeAnswerCollection.get()
    if @answers.objects.length > 2
      @answers.objects = @answers.objects[0..1]
    end

  end

  # GET last chamber agenda
  def get_current_chamber_agenda chamber
    query = sprintf("select * from data where chamber = '%s' order by date DESC limit 1", chamber)
    query = URI::escape(query)
    response = RestClient.get(ENV['agendas_url'] + query, :content_type => :json, :accept => :json, :"x-api-key" => ENV['morph_io_api_key'])
    response = JSON.parse(response).first
  end

  # GET the bills per agenda
  def get_bills_per_agenda bills_id
    @keywords = String.new
    bills_id.each do |bill_id|
      @keywords << bill_id + '|'
    end
    @keywords = URI::escape(@keywords)
    bills = Billit::BillCollectionPage.get(ENV['billit_url'] + "search/?uid=#{@keywords}", 'application/json')
  end

  def sitemap
    @congressmen = PopitPersonCollection.new
    @congressmen.get ENV['popit_persons']+'?per_page=200', 'application/json'
    @congressmen.persons.sort! { |x,y| x.name <=> y.name }
  end
end
