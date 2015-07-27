class AuthController < ApplicationController
  skip_before_action :require_user

  def signup
  end

  def login
    manager = UserManager.new(
      User::EMAIL,
      params.requre(:user).permit(:name, :email, :password, :confirmation)
    )
    manager.prepare
    self.user = manager.user
    render text: 'Logged In'
  end

  def logout
  end

  def callback
    manager = UserManager.new(params[:provider], request.env['omniauth.auth'])
    manager.prepare
    self.user = manager.user
    render text: 'Done'
  end
end
