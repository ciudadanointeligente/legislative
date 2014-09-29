class GlossariesController < ApplicationController
  before_action :set_glossary, only: [:show, :edit, :update, :destroy]

  # GET /glossaries
  def index
    @glossaries = Glossary.order("term").all
  end

  # GET /glossaries/1
  def show
  end

  # GET /glossaries/new
  def new
    @glossary = Glossary.new
  end

  # GET /glossaries/1/edit
  def edit
  end

  # POST /glossaries
  def create
    @glossary = Glossary.new(glossary_params)

    if @glossary.save
      redirect_to @glossary, notice: 'Glossary was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /glossaries/1
  def update
    if @glossary.update(glossary_params)
      redirect_to @glossary, notice: 'Glossary was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /glossaries/1
  def destroy
    @glossary.destroy
    redirect_to glossaries_url, notice: 'Glossary was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_glossary
      @glossary = Glossary.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def glossary_params
      params.require(:glossary).permit(:term, :definition)
    end
end
