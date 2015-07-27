class UserRoleManager
  def initialize(user)
    @user = user
  end

  def grant(role)
    return if user.has?(role)
    user.roles.create(name: role)
  end

  def revoke(role)
    return unless user.has?(role)
    user.roles.destroy(name: role)
  end

  def has?(role)
    user.roles.where(name: role).exists?
  end
end
