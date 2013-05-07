#encoding: utf-8
require 'billit_representers/representers/bill_representer'
require 'billit_representers/representers/bills_representer'

class BillsController < ApplicationController
  include Roar::Rails::ControllerAdditions

  def index
  end

  def edit
    @bill = Bill.get(params[:id], 'application/json')
  end

  def view
    @bill = Bill.get("http://billit.ciudadanointeligente.org/bills/#{params[:id]}", 'application/json')
  end

  def advanced_search
    if !params.nil? && params.length > 2 # default have 2 keys {'action'=>'advanced_search', 'controller'=>'bills'}
      keywords = String.new
      params.each do |param|
        if param[0] != 'utf8' && param[0] != 'commit'
         keywords << param[0] + '=' + param[1] + '&'
        end
      end
      @bills = Bills.get("http://billit.ciudadanointeligente.org/bills/search/?#{URI.encode(keywords)}", 'application/json').bills || []
    else
      # @bills = nil
    end
  end

  def search
    if !params.nil? && params.length > 2  # default have 2 keys {'action'=>'search', 'controller'=>'bills'}
      @bills = Bills.get("http://billit.ciudadanointeligente.org/bills/search?q=#{URI.encode(params[:q])}", 'application/json').bills || []
    else
      # @bills = nil
    end
  end

end
