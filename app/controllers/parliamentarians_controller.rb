class ParliamentariansController < ApplicationController

  # GET /parliamentarians
  def index
    @parliamentarians = PopitPersonCollection.new
    @parliamentarians.get ENV['popit_persons'], 'application/json'
  end

  # GET /parliamentarians/1
  def show
    #@parliamentarians = PopitPersonCollection.new
    #@parliamentarians.get ENV['popit_persons'], 'application/json'
    #@parliamentarians.persons.each do | parliamentarian |
    #  @parliamentarian = parliamentarian if parliamentarian.id == params[:id]
    #end
    @parliamentarian = PopitPerson.new
    @parliamentarian.name = 'Pedro Pablo Alvarez-Salamanca Ramirez'
    @parliamentarian.links = JSON.parse ('[{"url": "www.arenasdiputado.cl/","note": "Website"},{"url": "http://www.camara.cl/pdf.aspx?prmid=507&prmtipo=TRANSPARENCIA","note": "Declaration Interes"},{"url": "http://www.camara.cl/pdf.aspx?prmid=392&prmtipo=TRANSPARENCIA","note": "Declaration Patrimonio"},{"url": "http://facebook.com/group.php?gid=103267507483","note": "Facebook"}]')
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

  def searches
    @parliamentarians = PopitPersonCollection.new
    if !params.nil? && params.length > 3
      @parliamentarians.get ENV['popit_search']+"q="+params[:q], 'application/json'
    else
      @parliamentarians.get ENV['popit_search'], 'application/json'
    end
  end
end
