require 'net/http'
require 'httparty'
require 'billit_representers/models/bill'
require 'billit_representers/models/bill_page'

class SearchesController < ApplicationController
  def index
    response = HTTParty.get(ENV['popit_persons'])
    json_response = JSON.parse(response.body)
    authors_detail_list = json_response['result']

    @authors_list = []
    @persons_query = []
    authors_detail_list.map do |author|
      @authors_list.push(author['name'])
    end

    if !params.nil? && params.length > 3 # default have 3 keys {'action'=>'index', 'controller'=>'searchs', "locale"=>"xx"}
      
      # make a redirect in case of someone pick just one filter in main page
      # redirect to bills advanced search
      if params[:bills] == '1' || params[:parliamentarians] == ''
        redirect_to searches_bills_path(params)
      end
      # redirect to parliamentarians advanced search
      if params[:parliamentarians] == '2' || params[:bills] == ''
        redirect_to searches_parliamentarians_path(params)
      end

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
      @bills_query = Billit::BillCollectionPage.get(ENV['billit_url'] + "search.json/?#{URI.encode(@keywords)}&per_page=3", 'application/json')
    else
      @bills_query = Billit::BillCollectionPage.get(ENV['billit_url'] + "search.json/?per_page=3", 'application/json')
    end
    
    @parliamentarians = PopitPersonCollection.new
    @parliamentarians.get ENV['popit_persons'], 'application/json'
  end
end