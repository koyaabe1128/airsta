class Event < ApplicationRecord
  belongs_to :user
  
  validates :title, presence: true, length: { maximum:25 }
  validates :price, presence: true
  validates :place, presence: true, length: { maximum:25 }
  validates :genre, presence: true, length: { maximum:25 }
  validates :detail, presence: true, length: { maximum:255 }
  validates :event_at, presence: true
  validates :image, presence: true
  validate :event_at_cannot_past
  
  
  has_many :likes, dependent: :destroy
  
  mount_uploader :image, ImageUploader
  
  def event_at_cannot_past
    if event_at < Date.today
      errors.add(:event_at, "は過去の日付を選択できません")
    end
  end

end
