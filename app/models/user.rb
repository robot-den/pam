class User < ActiveRecord::Base

  # Include default devise modules. Others available are: :confirmable, :lockable and :timeoutable
  devise  :database_authenticatable, 
          :registerable, 
          :recoverable, 
          :rememberable, 
          :trackable, 
          :validatable, 
          :omniauthable

  has_many :articles
  has_and_belongs_to_many :categories

  # Name/email devise auth
  attr_accessor :login

  validates :name, :presence => true, :uniqueness => { :case_sensitive => false }
  #FIXME need change regular
  validates_format_of :name, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  # Overwrite devise's method for name/email login auth
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:name) || conditions.has_key?(:email)
      conditions[:email].downcase! if conditions[:email]
      where(conditions.to_hash).first
    end
  end

end
