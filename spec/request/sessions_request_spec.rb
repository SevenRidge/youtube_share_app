require 'rails_helper'

describe SessionsController, type: :request do
  before 'ユーザーIDをセッションから取り出せるようにする' do
    @user = FactoryBot.create(:user)
    visit login_path
    fill_in 'session_email', with: 'test1@example.com'
    fill_in 'session_password', with: 'password'
    click_button 'ログイン'
  end
  
  describe 'DELETE session' do  
    it 'ログアウト後のリダイレクト' do
      delete logout_path
      expect(response).to redirect_to root_path
    end

    it 'ログアウト後のセッションIDがnil' do
      delete logout_path
      expect(session[:user_id]).to eq nil
    end
  end

  describe 'Create session' do 
    it 'ログイン' do
      delete logout_path
      visit login_path
      fill_in 'session_email', with: 'test1@example.com'
      fill_in 'session_password', with: 'password'
      click_button 'ログイン'
      expect(response.status).to eq 302
    end

  end
end