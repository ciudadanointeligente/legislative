class GlossariesController < ApplicationController
  caches_page :index
  # GET /glossaries
  def index
    @title = t('glossaries.title') + ' - '
  end
end
