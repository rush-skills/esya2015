class StaticPagesController < ApplicationController
  before_action :set_static_page, only: [:show]

  # GET /static_pages
  # GET /static_pages.json
  def index
    @static_pages = StaticPage.all
  end

  # GET /static_pages/1
  # GET /static_pages/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_static_page
      @static_page = StaticPage.find(params[:id])
    end
end
