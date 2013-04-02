require "billit_representers/representers/bill_representer"
require "billit_representers/representers/bills_representer"

class BillsController < ApplicationController
  include Roar::Rails::ControllerAdditions

  def index
    @bills = Bills.get("http://localhost:9292/bills", 'application/json').bills
  end

  def edit
    @bill = Bill.get(params[:id], 'application/json')
  end

  def search
    puts '<params>'
    puts params
    puts '</params>'

    if !params.nil? && params.length > 2  # default have 2 keys {"action"=>"search", "controller"=>"bills"}
      @bills = Bills.get("http://localhost:9292/search/origin_chamber=#{params['origin_chamber']}", 'application/json').bills || []

      # @bills = Bills.get 'http://localhost:9292/search', 'application/json' do |request|
        # request.headers['Content-Type'] = 'application/json'
        # request.body = params.to_json
        # request.body = {origin_chamber: params['origin_chamber']}.to_json
        # puts '<origin_chamber>'
        # puts params['origin_chamber']
        # puts '</origin_chamber>'
      # end.bills

    else
      @bills = Bills.get("http://localhost:9292/search", 'application/json').bills
    end
  end

end
