class SessionsController < ApplicationController

  def new
    if params[:type].present?
      if params[:type].downcase == "user"
        redirect_to '/auth/'+params[:provider] + "/?user=1"
      else
        new_participant
      end
    else
      new_participant
    end
  end

  def new_participant
    redirect_to "/auth/" + params[:provider]
  end

  def get_current_participant
    render json: current_participant
  end

  def create
    auth = request.env["omniauth.auth"]
    params = request.env["omniauth.params"]
    is_user_auth = params["user"] == "1"
    if is_user_auth
      user = User.from_omniauth(auth)
      if user
        reset_session
        session[:user_id] = user.id
        redirect_to "/admin", :notice => 'Signed in!'
      else
        redirect_to root_url
      end
    else
      participant = Participant.from_omniauth(auth)
      if participant
        reset_session
        session[:participant_id] = participant.id
      end
      redirect_to fallback_redirect
      #replace the below for participant login
      # user = User.where(:provider => auth['provider'],
      #                   :uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
      # reset_session
      # session[:user_id] = user.id
    end
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end