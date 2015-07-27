module Legacy
  class WelcomeController < LegacyApplicationController
    skip_before_action :check_logged_in, only: [:index, :login, :ghetto]

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
      redirect_to attr_reader :oot_path
      end
    end

    def ghetto
      if request.post? && Attendee.find_by(id: params[:id])
        set_session(params[:id])
        redirect_to root_url
      end
    end
  end
end
