class ContactShare < ActiveRecord::Base
  validates :user_id, :contact_id, presence: true
  validates_uniqueness_of :contact_id, scope: :user_id

  belongs_to(
    :contact,
    class_name: "Contact",
    foreign_key: :contact_id,
    primary_key: :id
  )

  belongs_to(
    :user,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

end
