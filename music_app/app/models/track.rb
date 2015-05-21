class Track < ActiveRecord::Base
  validates :album_id, :name, presence: true
  validates :bonus, inclusion: {in: [true, false]}

  belongs_to(
  :album,
  class_name: 'Album',
  foreign_key: :album_id,
  primary_key: :id
  )

  has_many(
  :notes,
  class_name: 'Note',
  foreign_key: :track_id,
  primary_key: :id,
  dependent: :destroy
  )
end
