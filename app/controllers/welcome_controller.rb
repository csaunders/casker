class WelcomeController < ApplicationController
  skip_before_action :check_logged_in, only: [:index, :login]

  def index
    redirect_to drinks_path if attendee
  end

  def login
    attendee = Attendee.where(id: session[:id]).first_or_create
    session[:id] = attendee.id
    redirect_to drinks_path
  end

  def logout
    if params[:confirm]
      attendee.destroy
      reset_session

      flash[:notice] = "Thank you for using Casker"
      redirect_to root_path
    end
  end
end
