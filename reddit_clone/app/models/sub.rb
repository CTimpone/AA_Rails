class Sub < ActiveRecord::Base
  validates :title, :user, presence: true
  validates :title, uniqueness: true

  has_many :postsubs, inverse_of: :sub
  has_many :posts, through: :postsubs
  belongs_to :user, inverse_of: :subs
end
