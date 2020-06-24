class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :good_users, through: :likes, source: :user
  
  validates :comment, presence: true, length: { maximum: 30 }
    VALID_YOUTUBE_URL = /\Ahttps:\/\/(www\.youtube\.com\/watch\?v=|m\.youtube\.com\/watch\?v=|youtu\.be\/)[-\w]{11}\z/
  validates :youtube_url, format: { with: VALID_YOUTUBE_URL, message: "が誤っています"}
  validates :genre, presence: { message: "を指定してください" }

  def good?(user)
    good_users.include?(user)
  end

  def good(user)
    likes.create(user_id: user.id)
  end

  def ungood(user)
    likes.find_by(user_id: user.id).destroy
  end
end
