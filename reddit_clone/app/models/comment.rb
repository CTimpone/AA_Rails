class Comment < ActiveRecord::Base
  validates :user_id, :post_id, :content, presence: true

  belongs_to :user
  belongs_to :post
  
  belongs_to(
    :parent_comment,
    class_name: "Comment",
    foreign_key: :parent_id,
    primary_key: :id
  )

  has_many(
    :children,
    class_name: "Comment",
    foreign_key: :parent_id,
    primary_key: :id
  )

end
