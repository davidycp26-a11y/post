class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  before_action :set_locale

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      flash[:alert] = t('flash.login_required')
      redirect_to login_path
    end
  end

  def require_logout
    if logged_in?
      flash[:alert] = t('flash.already_logged_in')
      redirect_to root_path
    end
  end

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  private

  def set_locale
    locale = params[:locale] || session[:locale] || extract_locale_from_accept_language_header || I18n.default_locale
    I18n.locale = locale.to_sym if I18n.available_locales.include?(locale.to_sym)
    session[:locale] = I18n.locale
  end

  def extract_locale_from_accept_language_header
    return nil unless request.env['HTTP_ACCEPT_LANGUAGE']
    accepted = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/[a-z]{2}/).first
    I18n.available_locales.map(&:to_s).include?(accepted) ? accepted : nil
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
