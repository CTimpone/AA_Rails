require 'bcrypt'

class User < ActiveRecord::Base
  validates :username, :password_digest, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}

  has_many(
  :cats,
  class_name: 'Cat',
  foreign_key: :user_id,
  primary_key: :id
  )

  has_many(
  :rental_requests,
  class_name: 'CatRentalRequests',
  foreign_key: :user_id,
  primary_key: :id
  )

  has_many(
  :tokens,
  class_name: 'Session',
  foreign_key: :user_id,
  primary_key: :id
  )

  def self.find_by_credentials(user_name, password)
    user = User.find_by( username: user_name)
    return nil if user.nil?
    if user.is_password?(password)
      user
    else
      nil
    end
  end

  def new_session_token!
    session_token = SecureRandom::urlsafe_base64
    session = Session.new(user_id: self.id, token: session_token)
    session.save!
    session_token
  end

  def password= (password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def password
    @password
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

end
