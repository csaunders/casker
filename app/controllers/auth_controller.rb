class AuthController < ApplicationController
  def signup
  end

  def login
    manager = UserManager.new(
      User::EMAIL,
      params.requre(:user).permit(:name, :email, :password, :confirmation),
      current_user
    )
    manager.activate
    self.current_user = manager.user
    render text: 'Logged In'
  end

  def logout
    reset_session
    redirect_to root_path
  end

  def callback
    manager = UserManager.new(params[:provider], request.env['omniauth.auth'], current_user)
    manager.activate
    self.user = manager.user
    render text: 'Done'
  end
end
