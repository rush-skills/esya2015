class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:create_api, :create_gcm]
  def new
    @redirect_url = request.env["HTTP_REFERER"] if  request.env["HTTP_REFERER"].present?
    @redirect_url ||= root_url
    if params[:type].present?
      if params[:type].downcase == "user"
        @redirect_url = "/admin"
        redirect_to '/auth/'+params[:provider] + "/?user=1&redirect_url="+@redirect_url
      else
        new_participant
      end
    else
      new_participant
    end
  end

  def new_participant
    redirect_to "/auth/" + params[:provider] + "/?redirect_url="+@redirect_url
  end

  def get_current_participant
    render json: current_participant
  end

  def create
    auth = request.env["omniauth.auth"]
    params = request.env["omniauth.params"]
    redirect_url = params["redirect_url"]
    is_user_auth = params["user"] == "1"
    if is_user_auth
      user = User.from_omniauth(auth)
      if user
        reset_session
        session[:user_id] = user.id
        redirect_to "/admin", :notice => 'Signed in!'
      else
        redirect_to redirect_url
      end
    else
      participant = Participant.from_omniauth(auth)
      if participant
        reset_session
        session[:participant_id] = participant.id
      end
      redirect_to redirect_url
      #replace the below for participant login
      # user = User.where(:provider => auth['provider'],
      #                   :uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
      # reset_session
      # session[:user_id] = user.id
    end
  end

  def destroy
    reset_session
    respond_to do |format|
      format.html {redirect_to root_url, :notice => 'Signed out!'}
      format.json {render json: {status: 200, message: "Signed out!"}}
    end
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end


  def create_api
    token = params[:token]
    response = HTTParty.get("https://www.googleapis.com/oauth2/v3/tokeninfo?access_token=" + token)
    auth = response

    uid = auth["sub"]
    email = auth["email"]

    participant = Participant.where("provider = ? AND uid = ? OR email = ?", "google_oauth2", uid, email).first_or_create! do |participant|
      participant.email = email
      participant.uid = uid
      participant.provider = "google_oauth2"
    end

    if participant
      reset_session
      session[:participant_id] = participant.id
      render json: {status: 200, message: "Success"}
    else
      render json: {status: 500, message: "Failed"}
    end
  end

  def create_gcm
    render json: {status: 200, key: 123}
  end

end