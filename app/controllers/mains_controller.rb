class MainsController < ApplicationController
  def index
    @condition_search = true
    @condition_priority_box = true
  end
end
