require 'billit_representers/models/bill'
require 'billit_representers/models/bill_page'

class BillsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  respond_to :html, :xls

  # GET /bills
  # GET /bills.json
  def index
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
    @condition_resume_bill = true
    @bill = Billit::Bill.get(ENV['billit_url'] + "#{params[:id]}", 'application/json')
    @popit_url = 'http://' + ENV['popit_url'] + '/persons/'

    # paperworks
    @date_freq = Array.new
    bill_range_dates = @bill.paperworks.map {|paperwork| Date.strptime(paperwork.date, "%Y-%m-%d")}

    top_date = Date.today
    bottom_date = top_date - ENV['bill_graph_day_interval'].to_i.days
    data_length = 0
    
    while data_length < ENV['bill_graph_data_length'].to_i do
      #comparación y agregar a @date_freq
      dates_in_range = bill_range_dates.select {|date| date <= top_date && date > bottom_date} 
      #array inverse
      @date_freq.unshift dates_in_range.length
      top_date = bottom_date
      bottom_date = top_date - ENV['bill_graph_day_interval'].to_i.days
      data_length += 1
    end

    #setup the title page
    @title = " - " + @bill.title

    @paperworks = @bill.paperworks
    response_with = @paperworks

    case @bill.status.strip
    when "Archivado"
      @icon_bill = 'filed.png'
    when "Publicado"
      @icon_bill = 'published.png'
    when "En tramitación"
      @icon_bill = 'paperwork.png' #icono pendiente 
    when "Rechazado"
      @icon_bill = 'rejected.png' 
    when "Retirado"
      @icon_bill = 'discarded.png' 
    else
      @icon_bill = ''
    end
  end

  # GET /bills/new
  # GET /bills/new.json
  def new
  end

  # GET /bills/1/edit
  def edit
  end

  # POST /bills
  # POST /bills.json
  def create
  end

  # PUT /bills/1
  # PUT /bills/1.json
  def update
    @bill = Billit::Bill.get(ENV['billit_url'] + "#{params[:id]}", 'application/json')
    
    !params[:tags].nil? ? @bill.tags = params[:tags] : @bill.tags = []
    @bill.put(ENV['billit_url'] + "#{params[:id]}", 'application/json')
    render text: params.to_s, status: 201
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
  end

  def searches
    response = Net::HTTP.get_response(ENV['popit_url'], '/api/v0.1/persons/')
    json_response = JSON.parse(response.body)
    authors_detail_list = json_response['result']

    @authors_list = []
    @persons_query = []
    authors_detail_list.map do |author|
      @authors_list.push(author['name'])
    end

    if !params.nil? && params.length > 3 # default have 3 keys {'action'=>'index', 'controller'=>'searchs', "locale"=>"xx"}
      @keywords = String.new
      params.each do |param|
        if param[0] != 'utf8' && param[0] != 'commit' && param[0] != 'format' && param[0] != 'locale' && param[0] != 'action'  && param[0] != 'controller'
         @keywords << param[0] + '=' + param[1] + '&'
        end
      end
      if params['authors'] != nil
        @authors_list = []
        authors_detail_list.map do |author|
          if params['authors'] == author['name']
            @persons_query.push(author)
          end
        end
      end
      
      # defaul limit, when a user make a search for a bills or congressmen
      limit = '3'
      # if a user make a specific search the limit change to, in this case, 30
      if params[:bills] || params[:congressmen]
        limit = '30'
      end

      @bills_query = Billit::BillCollectionPage.get(ENV['billit_url'] + "search/?#{URI.encode(@keywords)}&per_page="+limit, 'application/json')
    else
      @bills_query = Billit::BillCollectionPage.get(ENV['billit_url'] + "search/?", 'application/json')
    end
  end
end
