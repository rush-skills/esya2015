class SponsorsController < ApplicationController

  # GET /sponsors
  # GET /sponsors.json
  def index
    @sponsors = Sponsor.all
    @response = ""
    Sponsor.category.values.each do |x|
      filter = @sponsors.where(category: x)
      if filter.present?
        @response += "<h1>"+x
        @response += "s" if filter.count > 1
        @response +="</h1>"
      end
      filter.each do |spons|
        @response += '<img class="spons" height="250px" src="'+spons.image.url+'">' if spons.image.present?
      end
    end
  end
end
