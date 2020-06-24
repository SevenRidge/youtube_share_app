require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "# new" do
    before do
      @user = FactoryBot.build(:user)
      @post = FactoryBot.build(:post, user: @user)
    end

    it "ひとことが空欄" do
      @post.comment = ""
      @post.valid?
      expect(@post.errors[:comment]).to include("を入力してください")

      @post.comment = "良い動画です"
      @post.valid?
      expect(@post).to be_valid
    end
    
    it "YouTubeのURLが空欄" do
      @post.youtube_url = ""
      @post.valid?
      expect(@post.errors[:youtube_url]).to include("が誤っています")

      @post.youtube_url = "https://www.youtube.com/watch?v=fTjTVekQGdA"
      @post.valid?
      expect(@post).to be_valid
    end

    it "ジャンルが空欄" do
      @post.genre = ""
      @post.valid?
      expect(@post.errors[:genre]).to include("を指定してください")

      @post.genre = "music"
      @post.valid?
      expect(@post).to be_valid
    end

    it "ひとことの文字数が30文字より大きい" do
      @post.comment = "a" * 31
      @post.valid?
      expect(@post.errors[:comment]).to include("は30文字以内で入力してください")

      @post.comment = "a" * 18
      @post.valid?
      expect(@post).to be_valid
    end

    it "YouTubeのURLがPCのブラウザから取得" do
      @post.youtube_url = "https://www.example.com/index/123456789012"
      @post.valid?
      expect(@post.errors[:youtube_url]).to include("が誤っています")

      @post.youtube_url = "https://www.youtube.com/watch?v=q9PkFk2CHJQ"
      @post.valid?
      expect(@post).to be_valid
    end

    it "YouTubeのURLがiPhoneアプリから取得" do
      @post.youtube_url = "https://youtu.be/awJkJpkGJYQ"
      @post.valid?
      expect(@post).to be_valid
    end
  end
end
