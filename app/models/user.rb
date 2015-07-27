class User < ActiveRecord::Base
  has_secure_password
  GUEST = "guest_account"
  EMAIL = "email"
  OAUTH = %w(facebook google_oauth2)
  AUTHENTICATION_PROVIDERS = %w(email guest_account facebook google_oauth2)
  validate :account_authentication

  has_many :roles, dependent: :destroy
  has_many :tasting_notes, dependent: :destroy

  def guest?
    authenticated_by == GUEST
  end

  def oauth?
    OAUTH.include?(authenticated_by)
  end

  private
  def account_authentication
    return if AUTHENTICATION_PROVIDERS.include?(authenticated_by)
    errors.add(:authenticated_by, "#{authenticated_by} is not a valid authentication provider")
  end
end
