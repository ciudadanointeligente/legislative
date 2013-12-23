class ParliamentariansController < ApplicationController

  # GET /parliamentarians
  def index
    @parliamentarians = PopitPersonCollection.new
    @parliamentarians.get ENV['popit_persons'], 'application/json'
  end

  # GET /parliamentarians/1
  def show
  end

  # GET /parliamentarians/new
  def new
    # @parliamentarian = Parliamentarian.new
  end

  # GET /parliamentarians/1/edit
  def edit
  end

  # POST /parliamentarians
  def create
    # @parliamentarian = Parliamentarian.new(parliamentarian_params)

    # if @parliamentarian.save
    #   redirect_to @parliamentarian, notice: 'Parliamentarian was successfully created.'
    # else
    #   render action: 'new'
    # end
  end

  # PATCH/PUT /parliamentarians/1
  def update
    # if @parliamentarian.update(parliamentarian_params)
    #   redirect_to @parliamentarian, notice: 'Parliamentarian was successfully updated.'
    # else
    #   render action: 'edit'
    # end
  end

  # DELETE /parliamentarians/1
  def destroy
    # @parliamentarian.destroy
    # redirect_to parliamentarians_url, notice: 'Parliamentarian was successfully destroyed.'
  end
end
