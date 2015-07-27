class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_user

  def logged_in?
    user.present?
  end

  def user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user=(user)
    return unless user.persisted?
    session[:user_id] = user.id
    @user = user
  end

  private
  def require_user
    return unless user
    password = SecureRandom.hexdigest
    self.user = User.create(
      identifier: SecureRandom.hexdigest,
      authenticated_by: User::GUEST,
      password: password,
      password_confirmation: password
    )
  end
end
