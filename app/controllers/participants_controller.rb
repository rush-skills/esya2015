class ParticipantsController < ApplicationController
  before_filter :authenticate_participant!
  def profile
    @participant = current_participant
    respond_to do |format|
      format.html
      format.json
    end
  end
end