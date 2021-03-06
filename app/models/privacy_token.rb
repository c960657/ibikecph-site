class PrivacyToken < ActiveRecord::Base
  before_validation       :salt_signature

  validates_uniqueness_of :signature
  validates_presence_of   :signature, :email, :password
  validates_length_of     :password, minimum: 8, maximum: 50

  attr_accessor           :email, :password

  def self.find_by_email_and_password(email, password)
    signature = PrivacyToken.generate_signature email, password
    PrivacyToken.find_by_signature signature
  end

  def self.find_or_create_by_user_info(email, password)
    PrivacyToken.find_by_email_and_password(email, password) || PrivacyToken.create(email: email, password: password)
  end

  private
  def set_signature
    self.signature = PrivacyToken.generate_signature self.email, self.password
  end

  def self.generate_signature(email, password)
    BCrypt::Engine.hash_secret email + password, ENV['BCRYPT_SALT']
  end
end
