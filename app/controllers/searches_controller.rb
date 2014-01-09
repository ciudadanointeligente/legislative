require 'net/http'

class SearchesController < ApplicationController
  def index
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
      @bills_query = BillCollectionPage.get(ENV['billit'] + "search/?#{URI.encode(@keywords)}&per_page=3", 'application/json')
    else
      @bills_query = BillCollectionPage.get(ENV['billit'] + "search/?per_page=3", 'application/json')
    end
    
    @parliamentarians = PopitPersonCollection.new
    @parliamentarians.get ENV['popit_persons'], 'application/json'
  end
end
