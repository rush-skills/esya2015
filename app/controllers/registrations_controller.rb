class RegistrationsController < ApplicationController
  before_filter :authenticate_participant!
  def create
    @event = Event.find_by_id(params[:id])
    if @event
      if @event.registered? current_participant
        respond_to do |format|
          format.html{
            redirect_to fallback_redirect
          }
          format.json{
            render json: {data: "Already Registered"}
          }
        end
      else
        registration = Registration.create(event: @event, participant: current_participant)
        if registration
          respond_to do |format|
            format.html{
              redirect_to fallback_redirect
            }
            format.json{
              render json: {data: "Success"}
            }
          end
        else
          respond_to do |format|
            format.html{
              redirect_to fallback_redirect
            }
            format.json{
              render json: {data: "Failure"}
            }
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