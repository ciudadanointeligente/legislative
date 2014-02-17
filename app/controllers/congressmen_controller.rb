class CongressmenController < ApplicationController

  # GET /congressmen
  def index
    @congressmen = PopitPersonCollection.new
    @congressmen.get ENV['popit_persons'], 'application/json'
  end

  # GET /congressmen/1
  def show
    #@congressmen = PopitPersonCollection.new
    #@congressmen.get ENV['popit_persons'], 'application/json'
    #@congressmen.persons.each do | congressman |
    #  @congressman = congressman if congressman.id == params[:id]
    #end
    @congressman = PopitPerson.new
    @congressman.name = 'Pedro Pablo Alvarez-Salamanca Ramirez'
    @congressman.links = JSON.parse ('[{"url": "www.arenasdiputado.cl/","note": "Website"},{"url": "http://www.camara.cl/pdf.aspx?prmid=507&prmtipo=TRANSPARENCIA","note": "Declaration Interes"},{"url": "http://www.camara.cl/pdf.aspx?prmid=392&prmtipo=TRANSPARENCIA","note": "Declaration Patrimonio"},{"url": "http://facebook.com/group.php?gid=103267507483","note": "Facebook"}]')
  end

  # GET /congressmen/new
  def new
    # @congressman = Congressman.new
  end

  # GET /congressmen/1/edit
  def edit
  end

  # POST /congressmen
  def create
    # @congressman = Congressman.new(congressman_params)

    # if @congressman.save
    #   redirect_to @congressman, notice: 'Congressman was successfully created.'
    # else
    #   render action: 'new'
    # end
  end

  # PATCH/PUT /congressmen/1
  def update
    # if @congressman.update(congressman_params)
    #   redirect_to @congressman, notice: 'Congressman was successfully updated.'
    # else
    #   render action: 'edit'
    # end
  end

  # DELETE /congressmen/1
  def destroy
    # @congressman.destroy
    # redirect_to congressmen_url, notice: 'Congressman was successfully destroyed.'
  end

  def searches
    @congressmen = PopitPersonCollection.new
    if !params.nil? && params.length > 3
      @congressmen.get ENV['popit_search']+"q="+params[:q], 'application/json'
    else
      @congressmen.get ENV['popit_search'], 'application/json'
    end
  end
end
