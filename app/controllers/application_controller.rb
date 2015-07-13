class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, :alert => exception.message
  end

  helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
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

    def correct_user?
      @user = User.find(params[:id])
      unless current_user == @user
        redirect_to root_url, :alert => "Access denied."
      end
    end

    def authenticate_user!
      if !current_user
        redirect_to root_url, :alert => 'You need to sign in for access to this page.'
      end
    end

    #-> Prelang (user_login:devise)
    def require_user_signed_in
      unless user_signed_in?

        # If the user came from a page, we can send them back.  Otherwise, send
        # them to the root path.
        if request.env['HTTP_REFERER']
          fallback_redirect = :back
        elsif defined?(root_path)
          fallback_redirect = root_path
        else
          fallback_redirect = "/"
        end

        redirect_to fallback_redirect, flash: {error: "You must be signed in to view this page."}
      end
    end

end
