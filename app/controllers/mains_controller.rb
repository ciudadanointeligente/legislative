class MainsController < ApplicationController
  def index
    @condition_search = true
    @condition_priority_box = true
    
    #@tables = TableCollection.new
    #@tables.get(ENV['tables'],'application/json')

    #@bills = BillCollection.new
    #@bills.get(ENV['billit']+'search.json?per_page=6', 'application/json')
  end
end
