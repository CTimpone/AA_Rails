class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :username, uniqueness: true
  validates :password, length: {minimum: 6}, allow_nil: true
  after_initialize :ensure_session

  has_many :subs, inverse_of: :user
  has_many :posts, inverse_of: :user
  has_many :comments, inverse_of: :user

  attr_reader :password

  def self.generate_secure_random
    SecureRandom.urlsafe_base64
  end

  def self.find_by_credentials(user_params)
    user = User.find_by(username: user_params[:username])
    return nil if user.nil?
    return user if user.is_password?(user_params[:password])
    nil
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    @password = password
  end

  def reset_session_token
    self.session_token = User.generate_secure_random
    self.save!
    self.session_token
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  private
  def ensure_session
    self.session_token ||= User.generate_secure_random
  end
end
