require "billit_representers/representers/bill_representer"
require "billit_representers/representers/bills_representer"

class BillsController < ApplicationController
  include Roar::Rails::ControllerAdditions

  def index
  end

  def edit
    @bill = Bill.get(params[:id], 'application/json')
  end

  def search
    if !params.nil? && params.length > 2  # default have 2 keys {"action"=>"search", "controller"=>"bills"}
      @bills = Bills.get("http://billit.ciudadanointeligente.org/bills/search?q=#{params[:q]}", 'application/json').bills || []
    else
      # @bills = nil
    end
  end

end
