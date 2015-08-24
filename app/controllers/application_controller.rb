class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def logged_in?
    current_user.present?
  end

  def current_user
    @user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    @user ||= default_user
  end

  def current_user=(user)
    return unless user.persisted?
    session[:user_id] = user.id
    @user = user
  end

  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end

  private
  def default_user
    password = SecureRandom.hex
    self.current_user = User.new(
      identifier: SecureRandom.uuid,
      authenticated_by: User::GUEST,
      password: password,
      password_confirmation: password
    )
  end
end
