class LandingsController < ApplicationController
  layout 'ide', only: [:home]
  layout 'cs', only: [:coming_soon]
  def index
  end
  def home
  end
  def mhome
  end
  def coming_soon
  end
end
