require "rails_helper"

  describe "投稿管理機能", type: :system do

    describe "投稿編集機能" do
      context "ユーザーAでログインしている時" do
        before do
          user_a= FactoryBot.create(:user, name: "user_a", email:"user_a@example.com", password: "password")
          FactoryBot.create(:post, comment: "This is user_a comment", user: user_a)
          visit login_path
          fill_in "session[email]", with: "user_a@example.com"
          fill_in "session[password]", with: "password"
          click_button "ログイン"
        end

        it "投稿を編集する" do
          click_link "user_a"
          click_link "マイページ"
          click_link "編集"
          fill_in "ひとこと", with: "Nice music"
          click_on "更新する"
          expect(page).to have_content "編集できました"
          expect(page).to have_content "Nice music"
        end
        it "投稿を削除する" do
          click_link "user_a"
          click_link "マイページ"
          click_link "削除"
          page.driver.browser.switch_to.alert.dismiss
          expect(page).to have_no_content "削除に成功しました"
          click_link "削除"
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content "削除に成功しました"
          expect(page).to have_no_content "This is user_a comment"
        end
      end
    end

    describe "いいね機能" do
      context "ユーザーAでログインしている時" do
        before do
          user_a= FactoryBot.create(:user, name: "user_a", email:"user_a@example.com", password: "password")
          FactoryBot.create(:post, youtube_url:"https://www.youtube.com/watch?v=dYNpMjCplMQ", comment:"This is user_a comment", user: user_a)
          user_b = FactoryBot.create(:user, name: "user_b", email:"user_b@example.com", password: "password")
          FactoryBot.create(:post, youtube_url:"https://www.youtube.com/watch?v=1jIiYeQg_2Q", comment:"This is user_b comment", user: user_b)
          visit login_path
          fill_in "session[email]", with: "user_a@example.com"
          fill_in "session[password]", with: "password"
          click_button "ログイン"
        end
      
        it "ユーザーBの投稿にいいねをする(Ajaxチェック)" do
          click_link "すべて"
          find(".far").click
          expect(page).to have_css ".fas"
          expect(page).to have_css ".like", text: "1"
        end

        it "ユーザーBの投稿のいいねを解除する(Ajaxチェック)" do
          click_link "すべて"
          find(".far").click
          find(".fas").click
          expect(page).to have_css ".far"
          expect(page).to have_css ".like", text: "0"
        end

        it "ユーザーBの投稿にいいねし、ユーザーページのカウントを確認する" do
          click_link "すべて"
          find(".far").click
          first(".card").click_link("user_a")
          expect(page).to have_content "いいね:1"
        end
      end
    end

    describe "フォロー機能" do
      context "ユーザーAでログインしている時" do
        before do
          user_b = FactoryBot.create(:user, name: "user_b", email:"user_b@example.com", password: "password")
          FactoryBot.create(:post, youtube_url:"https://www.youtube.com/watch?v=1jIiYeQg_2Q", comment:"This is user_b comment", user: user_b)
          user_a= FactoryBot.create(:user, name: "user_a", email:"user_a@example.com", password: "password")
          FactoryBot.create(:post, youtube_url:"https://www.youtube.com/watch?v=dYNpMjCplMQ", comment:"This is user_a comment", user: user_a)
          visit login_path
          fill_in "session[email]", with: "user_a@example.com"
          fill_in "session[password]", with: "password"
          click_button "ログイン"
        end

        it "ユーザーBをフォローする(Ajaxチェック)" do
          click_link "すべて"
          first(".card").click_link("user_b")
          click_on "フォローする"
          expect(page).to have_button "フォロー中"
        end

        it "ユーザーBをフォロー解除する(Ajaxチェック)" do
          click_link "すべて"
          click_link "user_b"
          click_on "フォローする"
          click_on "フォロー中"
          expect(page).to have_button "フォローする"
        end

        it "ユーザーAのフォロー数が反映される" do
          click_link "すべて"
          # first(".card").click_link("user_b")
          click_link "user_b"
          click_on "フォローする"
          
          first(".navbar").click_link "user_a"
          click_on "マイページ"
          click_on "フォロー"
          expect(page).to have_content "フォロー:1"
          expect(page).to have_content "user_b"
        end
        
        it "ユーザーBのフォロワー数が反映される" do
          click_link "すべて"
          click_link "user_b"
          click_on "フォローする"
          click_on "フォロワー"

          expect(page).to have_content "フォロワー:1"
          expect(page).to have_content "user_a"
        end
      end
    end
  end