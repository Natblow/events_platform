class Event < ApplicationRecord
  has_many :attendees
  belongs_to :user
  mount_uploader :image, ImageUploader
  validates :image, file_size: { less_than: 2.megabytes }

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
