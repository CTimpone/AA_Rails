class Cat < ActiveRecord::Base

  COAT_COLORS = %w( white black yellow orange gray brown )

  validates :birth_date, :color, :name, :sex, :user_id, presence: true
  validates_uniqueness_of :name, scope: [:birth_date, :color, :sex]
  validates_inclusion_of :color, in: COAT_COLORS
  validates_inclusion_of :sex, in: %w( m f )

  belongs_to(
  :owner,
  class_name: 'User',
  foreign_key: :user_id,
  primary_key: :id
  )

  has_many(
  :rental_requests,
  class_name: 'CatRentalRequest',
  foreign_key: :cat_id,
  primary_key: :id
  )
end
