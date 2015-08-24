class UserManager
  def initialize(provider, auth_hash, default_user)
    @provider = provider
    @reader = reader_for(provider).new(auth_hash)
    @default_user = default_user
  end

  def user
    @user ||= User.where(authenticated_by: provider, identifier: identifier).first
    @user ||= @default_user
  end

  def activate
    return unless user.guest?
    update_user
    apply_roles
  end

  private
  attr_accessor :reader, :provider, :default_user
  delegate :identifier, to: :reader

  def reader_for(provider)
    case provider
    when 'email' then "UserManager::EmailCredentialReader".constantize
    else "UserManager::OAuthCredentialReader".constantize
    end
  end

  def update_user
    user.update_attributes(
      authenticated_by: provider,
      identifier: identifier,
      name: reader.name,
      password: reader.password,
      password_confirmation: reader.password_confirmation
    )
  end

  def apply_roles
   manager = UserRoleManager.new(user)
   manager.grant(Role::USER)
   manager.grant(Role::ADMIN)
  end

  class EmailCredentialReader
    def initialize(credentials)
      @credentials = credentials
    end

    def identifier
      @credentials[:email]
    end

    def password
      @credentials[:password]
    end

    def password_confirmation
      @credentials[:confirmation]
    end

    def name
      @credentials[:name]
    end
  end

  class OAuthCredentialReader
    attr_reader :password, :password_confirmation
    def initialize(auth_hash)
      @auth_hash = auth_hash
      @password = @password_confirmation = SecureRandom.hex
    end

    def identifier
      @auth_hash[:uid].to_s
    end

    def name
      @auth_hash[:info][:name]
    end
  end
end
