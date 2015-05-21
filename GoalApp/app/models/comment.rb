class Comment < ActiveRecord::Base

  validates :author_id, :body, presence: true
  validates :commentable_type, inclusion: {in: ["PersonalGoal", "User"]}

  belongs_to(
    :author,
    class_name: 'User',
    foreign_key: :author_id,
    primary_key: :id
  )

  belongs_to :commentable, polymorphic: true
end
