class LandingsController < ApplicationController
  layout :resolve_layout
  before_filter :check_mobile, only: [:home]
  def index
  end
  def home
    @type = params[:type]
    @value = params[:value]
  end
  def mhome
    @pages = StaticPage.all
  end
  def coming_soon
  end

  def schedule
    @schedule = '<img src="http://esya.iiitd.edu.in/img/Day1.png" class="schedule"> <img src="http://esya.iiitd.edu.in/img/Day2.png" class="schedule">'
    render json: {combined: @schedule,name: "Schedule"}
  end

  private

  def resolve_layout
    case action_name
    when "index", "mhone"
      "application"
    when "home"
      "ide"
    when "coming_soon"
      "cs"
    else
      "application"
    end
  end
end
