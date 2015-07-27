class UserManager
  def initialize(provider, auth_hash)
    @provider = provider
    @reader = reader_for(provider).new(auth_hash)
  end

  def prepare
    return unless user.new_record?
    user.update_attributes(
      name: reader.name,
      password: reader.password,
      password_confirmation: reader.password_confirmation
    )
  end

  def activate(user)
    return unless user.guest?
    user.update_attributes(
      authenticated_by: provider,
      identifier: identifier,
      name: reader.name,
      password: reader.password,
      password_confirmation: reader.password_confirmation
    )
  end

  def user
    @user ||= User.where(authenticated_by: provider, identifier: identifier).first_or_initialize
  end

  private
  attr_accessor :reader, :provider
  delegate :identifier, to: :reader

  def reader_for(provider)
    case provider
    when 'email' then "UserManager::EmailCredentialReader".constantize
    else "UserManager::OAuthCredentialReader".constantize
    end
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
      puts auth_hash.inspect
      @auth_hash = auth_hash
      @password = @password_confirmation = SecureRandom.hex
    end

    def identifier
      @auth_hash[:uid]
    end

    def name
      @auth_hash[:info][:name]
    end
  end
end
