require "rails_helper"

RSpec.describe User, type: :model do
  describe "# create" do
    before do
      @user = FactoryBot.build(:user)
    end

      it "画像が空欄かどうか" do
        @user.image = nil
        @user.valid?
        expect(@user).to be_valid
      end

      it "名前が空欄かどうか" do
        @user.name = ""
        @user.valid?
        expect(@user.errors[:name]).to include("を入力してください")

        @user.name = "testuser"
        @user.valid?
        expect(@user).to be_valid
      end

      it "Eメールが空欄かどうか" do
        @user.email = ""
        @user.valid?
        expect(@user.errors[:email]).to include("を入力してください")

        @user.email = "testuser@email.com"
        @user.valid?
        expect(@user).to be_valid
      end

      it "パスワードまたはパスワード確認が空欄" do
        user = FactoryBot.build(:user, password: "", password_confirmation: "")
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")

        @user.password = "password"
        @user.password_confirmation = "password"
        @user.valid?
        expect(@user).to be_valid

      end

      it "パスワードとパスワード確認が一致しない" do
        user = FactoryBot.build(:user, password: "password", password_confirmation: "aaa")
        user.valid?
        expect(user.errors[:password_confirmation]).to include("とパスワードの入力が一致しません")

        @user.password = "password"
        @user.password_confirmation = "password"
        @user.valid?
        expect(@user).to be_valid
      end

      it "名前の文字数が15文字より大きい" do
        user = FactoryBot.build(:user, name: "a" * 16)
        user.valid?
        expect(user.errors[:name]).to include("は15文字以内で入力してください")

        @user.name = "a" * 15
        @user.valid?
        expect(@user).to be_valid
      end

      it "Eメールの文字数が64文字より大きい" do
        # a(53文字) + @example.com(12文字) = 65文字
        user = FactoryBot.build(:user, email: "a" * 53 + "@example.com")
        user.valid?
        expect(user.errors[:email]).to include("は64文字以内で入力してください")

        @user.email = "a" * 52 + "@example.com"
        @user.valid?
        expect(@user).to be_valid
      end

      it "Eメールに一意性がある" do
        user = FactoryBot.create(:user)
        duplicate_user = FactoryBot.build(:user, email: user.email.upcase)
        duplicate_user.valid?
        expect(duplicate_user.errors[:email]).to include("はすでに存在します")

        @user.email = "bbb@example.com"
        @user.valid?
        expect(@user).to be_valid
      end

      it "Eメールを大文字小文字混在で登録しても、小文字に変換されている" do
        user = FactoryBot.create(:user, email: "Mixed_case_EMaiL@ExamPLE.CoM")
        expect(user[:email]).to eq "mixed_case_email@example.com"
      end

      it "パスワードの文字数が6文字未満" do
        user = FactoryBot.build(:user, password: "a" * 5)
        user.valid?
        expect(user.errors[:password]).to include("は6文字以上で入力してください")

        @user.password = "123456"
        @user.password_confirmation = "123456"
        @user.valid?
        expect(@user).to be_valid
      end

      it "パスワードの文字数が20文字より大きい" do
        user = FactoryBot.build(:user, password: "a" * 21)
        user.valid?
        expect(user.errors[:password]).to include("は20文字以内で入力してください")

        @user.password = "12345678901234567890"
        @user.password_confirmation = "12345678901234567890"
        @user.valid?
        expect(@user).to be_valid
      end
  end
end