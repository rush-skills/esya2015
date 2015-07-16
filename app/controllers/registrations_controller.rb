class RegistrationsController < ApplicationController
  before_filter :authenticate_participant!
  def create
    @event = Event.find_by_id(params[:id])
    if @event
      if @event.registered? current_participant
        respond_to do |format|
          format.html{redirect_to fallback_redirect}
          format.json{
            render json: {data: "Already Registered"}
          }
        end
      else
        if @event.team_event?
          if params[:team_code].present?
            @team = Team.find_by_tid(params[:team_code])
            if @team
              @participant_team = ParticipantTeam.create(team: @team, participant: current_participant)
              if @participant_team
                team_code = "You have "+@team.participants.count.to_s + " team members. Add more team members by using team code: " + @team.tid.to_s
                respond_to do |format|
                  format.html{redirect_to fallback_redirect}
                  format.json{render json: {data: "Success", extra_data: team_code,team_code: @team.tid.to_s,team_size: @team.participants.count}}
                end
              else
                respond_to do |format|
                  format.html{redirect_to fallback_redirect}
                  format.json{render json: {data: "Failure", extra_data: "Error creating registration"}}
                end
              end
            else
              respond_to do |format|
                format.html{redirect_to fallback_redirect}
                format.json{render json: {data: "Failure", extra_data: "Invalid Team Code."}}
              end
            end
          elsif params[:team_name].present?
            @team = Team.create(event: @event, team_name: params[:team_name])
            if @team
              @participant_team = ParticipantTeam.create(team: @team, participant: current_participant)
              if @participant_team
                team_code = "You have "+@team.participants.count.to_s + " team members. Add more team members by using team code: " + @team.tid.to_s
                respond_to do |format|
                  format.html{redirect_to fallback_redirect}
                  format.json{render json: {data: "Success", extra_data: team_code,team_code: @team.tid.to_s,team_size: @team.participants.count}}
                end
              else
                respond_to do |format|
                  format.html{redirect_to fallback_redirect}
                  format.json{render json: {data: "Failure", extra_data: "Error creating registration"}}
                end
              end
            else
              respond_to do |format|
                format.html{redirect_to fallback_redirect}
                format.json{render json: {data: "Failure", extra_data: "Error creating team."}}
              end
            end
          else
            respond_to do |format|
              format.html{redirect_to fallback_redirect}
              format.json{render json: {data: "Failure", extra_data: "Something went wrong."}}
            end
          end
        else
          registration = Registration.create(event: @event, participant: current_participant)
          if registration
            respond_to do |format|
              format.html{redirect_to fallback_redirect}
              format.json{render json: {data: "Success"}}
            end
          else
            respond_to do |format|
              format.html{redirect_to fallback_redirect}
              format.json{render json: {data: "Failure"}}
            end
          end
        end
      end
    else
      respond_to do |format|
        format.html{
          redirect_to root_url
        }
        format.json{
          render json: {data: "Invalid event"}
        }
      end
    end
  end

  def check
    @event = Event.find_by_id(params[:id])
    registered?(@event)
  end
end