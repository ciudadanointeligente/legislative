class GlossariesController < ApplicationController
  # GET /glossaries
  def index
    @title = t('glossaries.title') + ' - '
  end
end
