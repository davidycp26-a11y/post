class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  before_action :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      flash[:alert] = "You must be logged in to access this section."
      redirect_to login_path
    end
  end

  def require_logout
    if logged_in?
      flash[:alert] = "You are already logged in."
      redirect_to root_path
    end
  end 
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
end
  