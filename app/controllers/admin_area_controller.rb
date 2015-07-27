class AdminAreaController < ApplicationController
  before_action :require_admin

  private
  def require_admin
    user.roles.admin?
  end
end
