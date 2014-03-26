require 'billit_representers/models/bill'
require 'billit_representers/models/bill_page'
require './app/models/bill'
require './app/models/paperwork'

class BillsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  respond_to :html, :xls

  # GET /bills
  # GET /bills.json
  def index
    redirect_to url_for :controller => 'bills', :action => 'searches'
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
    @condition_bill_header = true
    @bill = Billit::Bill.get(ENV['billit_url'] + "#{params[:id]}.json", 'application/json')

    # @authors = Hash.new
    # i = 0

    # if !@bill.authors.blank?
    #   @bill.authors.each do |author|
    #     @authors[i] = get_author_related_info author
    #     i = i + 1
    #   end
    # end

    #setup the title page
    @title = @bill.title + ' - '

    @paperworks = @bill.paperworks
    response_with = @paperworks
  end

  # GET authors related data
  def get_author_related_info author
    a = author.split(',')
    author = a[1].strip + ' ' + a[0].strip

    query = sprintf('select * from data where name = "%s" limit 1', I18n.transliterate(author))
    query = URI::escape(query)
    begin
      response = RestClient.get(ENV['congressmen_helper_url'] + query, :content_type => :json, :accept => :json, :"x-api-key" => ENV['morph_io_api_key'])
      response = JSON.parse(response).first
    rescue
      return {'uid' => nil, 'name' => ''}
    end
    if !response.nil?
      return {'uid' => response['uid'], 'name' => author}
    else
      return {'uid' => nil, 'name' => author}
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
    if !params.nil? && params.length > 3
      @keywords = String.new
      params.each do |key, value|
        if key != 'utf8' && key != 'locale' && !(value.is_a? Array) && !value.blank?
          @keywords << key + '=' + value + '&'
        elsif (value.is_a? Array)
          @keywords << key + '='
          array_keyword = String.new
          value.each_with_index do |priority_value, index|
            array_keyword << priority_value
            if index < value.size - 1
              array_keyword << '|'
            end
          end
          @keywords << array_keyword + '&'
        end
      end
      @bills_query = Billit::BillCollectionPage.get(ENV['billit_url'] + "search/?#{URI.encode(@keywords)}", 'application/json')
    else
      @bills_query = Billit::BillCollectionPage.get(ENV['billit_url'] + "search/?", 'application/json')
    end
  end
end
