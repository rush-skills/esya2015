class EventsController < ApplicationController
  before_action :set_event, only: [:show]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find_by_short_code(params[:id])
      unless @event
        @event = Event.find_by_id(params[:id])      
      end
    end

end
