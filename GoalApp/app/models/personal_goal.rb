class PersonalGoal < ActiveRecord::Base
  include Commentable

  validates :user_id, :body, presence: true

  validates :completed, inclusion: {in: [true, false], message: "You must select public or private"}
  validates :public, inclusion: {in: [true, false], message: "You must select completed or in progress"}


  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

end
