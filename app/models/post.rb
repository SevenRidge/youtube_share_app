class Post < ApplicationRecord
  belongs_to :user
  validates :comment, presence: true, length: { maximum: 30 }
  VALID_YOUTUBE_URL = /(\Ahttps:\/\/www\.youtube\.com\/watch\?v=)+[\w+-]{11}\z/
  validates :youtube_url, format: { with: VALID_YOUTUBE_URL, message: "は公式サイトから取得してください"}
  validates :genre, presence: { message: "を指定してください" }
end
