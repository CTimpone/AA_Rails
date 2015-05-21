class Postsub < ActiveRecord::Base
  validates :sub_id, :post, presence: true

  belongs_to :post
  belongs_to :sub
end
