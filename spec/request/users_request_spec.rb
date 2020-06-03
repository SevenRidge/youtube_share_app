require "rails_helper"

describe UsersController, type: :request do
  before "ユーザーと投稿の作成" do
    @user = FactoryBot.create(:user)
    # @post = FactoryBot.create(:post, user: @user)
  end

  describe "GET #new" do
    it "レスポンスが200である" do
      get new_user_path
      expect(response.status).to eq 200
    end
  end

  describe "GET #show" do
    context "ユーザーがDBに存在する場合" do
      before "ユーザーページが取得できる" do 
        get user_path @user.id
      end

      it "レスポンスが200である" do
        expect(response.status).to eq 200
      end

      it "ユーザー名が画面に表示される" do
        expect(response.body).to include @user.name
      end

    end

    context "ユーザーがDBに存在しない場合" do
      subject {-> {get user_path @user.id + 1}}
      it {is_expected.to raise_error ActiveRecord::RecordNotFound}
    end
  end

  describe "User #create" do
    context "パラメータが正しい場合" do
      before do
        post users_path, params: { user: FactoryBot.attributes_for(:user) }
      end

      it "ユーザーがDBに登録される" do
        change(User, :count).by(1)
      end

      # it "ログイン状態である" do
      #   expect(session[:user_id]).to eq User.last.id
      # end

      it "レスポンスが302である" do
        expect(response.status).to eq 302
      end

      it "メッセージが表示される" do
        expect(flash[:success]).to eq "Welcome to Tube!"
      end

      it "リダイレクトされる" do
        expect(response).to redirect_to User.last
      end
    end

    context "パラメータが誤っている場合" do
      before do
        post users_path, params: { user: attributes_for(:user, :invalid) }
      end

      it "レスポンスが200である" do
        expect(response.status).to eq 200
      end

      it "リダイレクトされない" do
        expect(response.body).to include "会員登録"
      end

      it "メッセージが表示される" do
        expect(response.body).to include "個のエラーがあります" 
      end
    end
  end
end