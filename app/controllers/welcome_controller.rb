class WelcomeController < ApplicationController
  skip_before_action :check_logged_in, only: [:index, :login]

  def index
    redirect_to drinks_path if attendee
  end

  def login
    attendee = Attendee.where(id: session_id).first_or_create
    set_session(attendee.id)
    redirect_to drinks_path
  end

  def logout
    if params[:confirm]
      attendee.destroy
      cookies.delete :id
      reset_session

      flash[:notice] = "Thank you for using Casker"
      redirect_to root_path
    end
  end
end
