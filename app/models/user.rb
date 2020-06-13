class User < ApplicationRecord

  # ユーザープロフィール画像用 2020.05.23追加
  mount_uploader :image, ImageUploader

  # Remember me機能
  attr_accessor :remember_token

  has_many :posts, foreign_key: :user_id, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 10 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 64 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { in: 6..22 }

  has_many :relationships
  has_many :followings, through: :relationships, source: :follow, dependent: :destroy
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user, dependent: :destroy

  validates :sex, presence: :true
  validates :age, presence: :true

  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def follow(other_user)
    unless self == other_user
      self.relationships.create(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def self.guest
    find_or_create_by!(name: "閲覧用ユーザー", sex: "フリー", age:"26~30才", email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

end
