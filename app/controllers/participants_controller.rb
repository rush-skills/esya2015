class ParticipantsController < ApplicationController
  before_filter :authenticate_participant!
  def profile
    @participant = current_participant
    respond_to do |format|
      format.html
      format.json
    end
  end
  def update
    @participant = current_participant
    if current_participant.update_attributes(participant_params)
      respond_to do |format|
        format.html { flash[:success] = "Updated Successfully" }
        format.json {
          render json: {data: "Sucess"}
        }
      end
    else
      respond_to do |format|
        format.html { flash[:success] = "Update Failed" }
        format.json {
          render json: {data: "Failed"}
        }
      end
    end
  end

  private
  def participant_params
    params.require(:participant).permit(:name,:college,:email,:phone)
  end
end