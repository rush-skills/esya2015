class Users::SessionsController < Devise::SessionsController
  include ApplicationHelper

  def create
    super
  end

  def new
    redirect_to '/users/auth/google_oauth2'
  end
end
