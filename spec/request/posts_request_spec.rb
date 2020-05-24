require "rails_helper"

describe PostsController, type: :request do
  before "ユーザーと投稿の作成" do
    @post = FactoryBot.create(:post)
  end

  describe "#index" do
    context "トップページ" do
      it "レスポンスが200である" do
        get root_path
        expect(response.status).to eq 200
      end
    end
  end

  describe "#new" do
    it "レスポンスが200である" do
      get new_post_path
      expect(response.status).to eq 200
    end
  end

end