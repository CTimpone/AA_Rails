class User < ActiveRecord::Base
  include Commentable

  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: {minimum: 6}, allow_nil: true

  has_many(
    :personal_goals,
    class_name: "PersonalGoal",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :made_comments,
    class_name: 'Comment',
    foreign_key: :author_id,
    primary_key: :id
  )


  attr_reader :password

  after_initialize :ensure_session_token

  def self.find_by_credentials(params)
    user = User.find_by(username: params[:username])
    if user && user.is_password?(params[:password])
      return user
    end

    nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def reset_session_token
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

end
