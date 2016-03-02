# :nodoc:
class User < ActiveRecord::Base
  # Include default devise modules.
  devise  :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :trackable,
          :validatable,
          :async, :omniauthable, omniauth_providers: [:facebook]

  has_many :articles
  has_and_belongs_to_many :categories

  # # Name/email devise auth
  # attr_accessor :login

  validates :name, presence: true

  # # Name/email auth. Regular for escape name=email problems
  # validates_format_of :name, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  # # Overwrite devise's method for name/email login auth
  # def self.find_for_database_authentication(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if login = conditions.delete(:login)
  #     where(conditions.to_hash).where(["lower(name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  #   elsif conditions.has_key?(:name) || conditions.has_key?(:email)
  #     conditions[:email].downcase! if conditions[:email]
  #     where(conditions.to_hash).first
  #   end
  # end

  # Omniauth
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0, 20]
    end
  end

  # FIXME: METHODS FOR UNSUBSCRIBE LINK
  # Access token for a user
  def access_token
    User.create_access_token(self)
  end

  # Verifier based on our application secret
  def self.verifier
    ActiveSupport::MessageVerifier.new(Rails.application.secrets[:secret_key_base])
  end

  # Get a user from a token
  def self.read_access_token(signature)
    id = verifier.verify(signature)
    User.find_by_id id
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    nil
  end

  # Class method for token generation
  def self.create_access_token(user)
    verifier.generate(user.id)
  end
end
