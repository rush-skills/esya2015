class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, :alert => exception.message
  end

  before_filter :prepare_for_mobile

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
  end

  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?

  helper_method :current_participant
  helper_method :participant_signed_in?

  helper_method :registered?

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end

  def check_mobile
    if mobile_device?
      redirect_to "/m"
    end
  end

  def registered?(event)
    event.registered?(current_participant)
  end

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue Exception => e
      nil
    end
  end
  def current_participant
    begin
      @current_participant ||= Participant.find(session[:participant_id]) if session[:participant_id]
    rescue Exception => e
      nil
    end
  end
  def create_or_verify_user_login
    if current_user
      return true
    else
      redirect_to "/signin/google_oauth2/user"
    end
  end
  private

    def user_signed_in?
      return true if current_user
    end

    def participant_signed_in?
      return true if current_participant
    end


    def correct_user?
      @user = User.find(params[:id])
      unless current_user == @user
        redirect_to root_url, :alert => "Access denied."
      end
    end

    def authenticate_user!
      if !current_user
        redirect_to fallback_redirect
      end
    end

    def authenticate_participant!
      if !current_participant
        redirect_to fallback_redirect
      end
    end

    def fallback_redirect
      if request.env['HTTP_REFERER']
        fallback_redirect = :back
      elsif defined?(root_path)
        fallback_redirect = root_path
      else
        fallback_redirect = "/"
      end
    end

end
