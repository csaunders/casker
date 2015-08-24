class AdminAreaController < ApplicationController
  before_action :require_admin

  private
  def require_admin
    return if current_user.admin?
    render_404
  end
end
