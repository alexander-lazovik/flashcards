class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  private

  def set_locale
    locale = current_user.locale if current_user
    locale ||= params[:user_locale] || session[:locale] ||
               http_accept_language.compatible_language_from(I18n.available_locales)

    if locale && I18n.available_locales.include?(locale.to_sym)
      session[:locale] = I18n.locale = locale
    else
      session[:locale] = I18n.locale = I18n.default_locale
    end
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  # Active Admin calls this method to ensure that there is a currently logged in admin user
  def authenticate_admin_user!
    unless current_user && current_user.admin?
      redirect_to login_path, alert: t(:please_log_in_as_admin)
    end
  end
end
