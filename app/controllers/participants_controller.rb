class ParticipantsController < ApplicationController
  before_filter :authenticate_participant!, except: [:profile]
  def profile
    @participant = current_participant
    if current_participant
      respond_to do |format|
        format.html
        format.json
      end
    else
      respond_to do |format|
        format.html{ redirect_to fallback_redirect}
        format.json{ render json: {data: "Not logged in",login: false}}
      end
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