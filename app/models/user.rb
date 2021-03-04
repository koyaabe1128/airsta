class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :genre, length: { maximum: 30}
  validates :place, length: { maximum: 20}
  validates :introduction, length: { maximum:100 }

  has_secure_password
  
  has_many :events, dependent: :destroy
  
  has_many :likes, dependent: :destroy
  has_many :like_events, through: :likes, source: :event
  
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  mount_uploader :image, ImageUploader
  
  #いいねしているかを確認するメソッド
  def like?(other_event)
    self.like_events.include?(other_event)
  end
  
  #フォローしているかを確認するメソッド
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  #フォローするときのメソッド
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  #フォローを外すときのメソッド
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

end
