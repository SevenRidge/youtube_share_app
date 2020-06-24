require "rails_helper"

  describe "ログイン機能", type: :system do
    describe "未ログインで操作可能な機能" do
      before do
        @user_a= FactoryBot.create(:user, name: "user_a", email:"user_a@example.com", password: "password")
        FactoryBot.create(:post, comment: "This is user_a comment", user: @user_a)
      end

      context "ログインしていない時" do
        before do
          visit root_path
        end

        it "ゲストログインできる" do
          click_link "ゲストログイン"
          expect(page).to have_content "ゲストユーザーとしてログインしました"
        end

        it "通常ログインできる" do
          click_on "ログイン"
          fill_in "session[email]", with: "user_a@example.com"
          fill_in "session[password]", with: "password"
          click_button "ログイン"
          expect(page).to have_content "ログインしました"
          expect(page).to have_content "user_a"
        end

        it "投稿がジャンルページに表示される" do
          click_link "音楽"
          expect(page).to have_content "This is user_a comment"
          expect(page).to have_no_content "アニメ"
        end

        it "投稿がジャンルページに表示されない" do
          click_link "ゲーム"
          expect(page).to have_no_content "This is user_a comment"
          expect(page).to have_no_content "音楽"
          expect(page).to have_content "ゲーム"
        end

        it "投稿がすべてページに表示される" do
          click_link "すべて"
          expect(page).to have_content "This is user_a comment"
          expect(page).to have_content "音楽"
          expect(page).to have_content "すべて"
        end

        it "会員登録する_画像未指定" do
          visit root_path
          click_link "会員登録"
          fill_in "user[name]", with: "new_user"
          select "男", from: "user[sex]"
          select "10~19才", from: "user[age]"
          fill_in "user[email]", with: "new_user@example.com"
          fill_in "user[password]", with: "password"
          fill_in "user[password_confirmation]", with: "password"
          click_button "登録"
          expect(page).to have_content "会員登録が完了しました"
        end

        it "会員登録する_画像指定" do
          visit root_path
          click_link "会員登録"
          attach_file "spec/fixtures/profile_image.png"
          fill_in "user[name]", with: "new_user"
          select "男", from: "user[sex]"
          select "10~19才", from: "user[age]"
          fill_in "user[email]", with: "new_user@example.com"
          fill_in "user[password]", with: "password"
          fill_in "user[password_confirmation]", with: "password"
          click_button "登録"
          expect(page).to have_content "会員登録が完了しました"
        end

        it 'ログアウトができる' do
          visit login_path
          fill_in "session[email]", with: "user_a@example.com"
          fill_in "session[password]", with: "password"
          click_button "ログイン"

          click_link "user_a"
          click_link "ログアウト"
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content "ログアウトしました"
        end

        it "ログイン情報を記憶する" do
          visit login_path
          fill_in "session[email]", with: "user_a@example.com"
          fill_in "session[password]", with: "password"
          check '記憶する'
          click_button "ログイン"
          expect(User.find(@user_a.id).remember_digest).not_to be nil
        end

        it "ログイン情報が記憶されない" do
          visit login_path
          fill_in "session[email]", with: "user_a@example.com"
          fill_in "session[password]", with: "password"
          click_button "ログイン"
          expect(User.find(@user_a.id).remember_digest).to be nil
        end

        it "退会ができる" do
          click_on "ログイン"
          fill_in "session[email]", with: "user_a@example.com"
          fill_in "session[password]", with: "password"
          click_button "ログイン"
          click_link "user_a"
          click_link "マイページ"
          click_link "退会する"
          page.driver.browser.switch_to.alert.dismiss
          expect(page).to have_no_content "退会に成功しました"
        end
      end
    end
  end