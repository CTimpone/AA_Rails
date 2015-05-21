class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, :activation_token, presence: true
  validates :email, uniqueness: true
  validates :password, length: {minimum: 6}, allow_nil: true

  after_initialize :ensure_session_token
  before_validation :ensure_email_activation
  after_save :transmit_email

  has_many(
  :notes,
  class_name: 'Note',
  foreign_key: :user_id,
  primary_key: :id,
  dependent: :destroy
  )

  def self.find_by_credentials(user_params)
    email = user_params["email"]
    password = user_params["password"]
    user = User.find_by(email: email)
    return nil if user.nil?
    if user.is_password?(password)
      user
    else
      nil
    end
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def reset_session_token
    session[:token] = nil
    self.session_token = User.generate_session_token
  end

  def password=(password)
    @password = password
    pd = BCrypt::Password.create(password)
    self.password_digest = pd
  end

  def password
    @password
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def ensure_email_activation
    self.activated = false
    self.activation_token ||= User.generate_session_token
  end

  def transmit_email
    msg = UserMailer.activation_email(self)
    msg.deliver
  end
end
