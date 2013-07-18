#encoding: utf-8
require 'billit_representers/representers/bill_representer'
require 'billit_representers/representers/bill_collection_representer'

class BillsController < ApplicationController
  include Roar::Rails::ControllerAdditions

  # GET /bills
  # GET /bills.json
  def index
    # @bills = Bill.get("http://billit.ciudadanointeligente.org/bills/", 'application/json')

    # respond_to do |format|
      # format.html # index.html.erb
      # format.json { render json: @bills }
    # end
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
    @bill = Bill.get(ENV['billit'] + "#{params[:id]}", 'application/json')
    @popit_url = ENV['popit']

    # respond_to do |format|
      # format.html # show.html.erb
      # format.json { render json: @bill }
    # end
  end

  # GET /bills/new
  # GET /bills/new.json
  def new
    # @bill = Bill.new

    # respond_to do |format|
      # format.html # new.html.erb
      # format.json { render json: @bill }
    # end
  end

  # GET /bills/1/edit
  def edit
    # @bill = Bill.get(params[:id], 'application/json')
  end

  # POST /bills
  # POST /bills.json
  def create
    # @bill = Bill.new(params[:bill])

    # respond_to do |format|
    #   if @bill.save
    #     format.html { redirect_to @bill, notice: 'Bill was successfully created.' }
    #     format.json { render json: @bill, status: :created, location: @bill }
    #   else
    #     format.html { render action: "new" }
    #     format.json { render json: @bill.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PUT /bills/1
  # PUT /bills/1.json
  #def update
    # @bill = Bill.find(params[:id])

    # respond_to do |format|
    #   if @bill.update_attributes(params[:bill])
    #     format.html { redirect_to @bill, notice: 'Bill was successfully updated.' }
    #     format.json { head :no_content }
    #   else
    #     format.html { render action: "edit" }
    #     format.json { render json: @bill.errors, status: :unprocessable_entity }
    #   end
    # end
  #end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    # @bill = Bill.find(params[:id])
    # @bill.destroy

    # respond_to do |format|
    #   format.html { redirect_to bills_url }
    #   format.json { head :no_content }
    # end
  end

  def search
    if !params.nil? && params.length > 2 # default have 2 keys {'action'=>'advanced_search', 'controller'=>'bills'}
      keywords = String.new
      params.each do |param|
        if param[0] != 'utf8' && param[0] != 'commit'
         keywords << param[0] + '=' + param[1] + '&'
        end
      end
      @query = BillCollectionPage.get(ENV['billit'] + "search/?#{URI.encode(keywords)}", 'application/json')
      # @bills = query.bills || []
    end
  end

  def advanced_search
    @query = search
    render template: "bills/advanced_search"
  end

  def update
    @bill = Bill.get(ENV['billit'] + "#{params[:id]}", 'application/json')
    
    !params[:tags].nil? ? @bill.tags = params[:tags] : @bill.tags = []
    @bill.put(ENV['billit'] + "#{params[:id]}", 'application/json')
    render text: params.to_s, status: 201
  end
end