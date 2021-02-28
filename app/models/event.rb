class Event < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum:25 }
  validates :price, presence: true
  validates :place, presence: true, length: { maximum:25 }
  validates :genre, presence: true, length: { maximum:25 }
  validates :detail, presence: true, length: { maximum:255 }
  validates :event_at, presence: true
  validates :image, presence: true
  
  has_many :likes
  
  mount_uploader :image, ImageUploader

end
