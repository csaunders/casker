class LegacyApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :check_logged_in, :ensure_cookie

  helper_method :logged_in?, :class_for, :attendee

  def attendee
    @attendee ||= Attendee.includes(:drinks).where(id: session_id).first
  end

  def activate(section)
    active[section] = "active"
  end

  def class_for(section)
    active[section] || ""
  end

  def return_path
    request.referrer if params[:return].present?
  end

  protected
  def session_id
    session[:id] || cookies[:id]
  end

  def set_session(id)
    session[:id] = id
    cookies[:id] = id
  end

  private
  def check_logged_in
    unless attendee
      redirect_to root_path
    end
  end

  def ensure_cookie
    cookies[:id] = session[:id] if logged_in? && cookies[:id].blank?
  end

  def logged_in?
    attendee.present?
  end

  def active
    @active ||= {}
  end
end
