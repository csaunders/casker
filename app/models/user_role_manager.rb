class UserRoleManager
  def initialize(user)
    @user = user
  end

  def grant(role)
    return unless permitted_accounts(role).include?(user.identifier)
    user.roles.find_or_create(name: role)
  end

  def revoke(role)
    user.roles.destroy(name: role)
  end

  private
  attr_reader :user

  def permitted_accounts(role)
    return [user.identifier] if role == Role::USER
    (ENV["permitted_#{role}_users"] || "").split
  end
end
