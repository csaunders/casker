class AdminAreaController < ApplicationController
  before_action :require_admin

  protected
  def require_admin
    return if current_user.admin?
    render_404
  end
end
