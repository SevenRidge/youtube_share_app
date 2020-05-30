class User < ApplicationRecord

  # ユーザープロフィール画像用 2020.05.23追加
  mount_uploader :image, ImageUploader

  has_many :posts, foreign_key: :user_id, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 15 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 64 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { in: 6..20 }
end
