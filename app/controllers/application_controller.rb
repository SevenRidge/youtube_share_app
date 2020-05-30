class ApplicationController < ActionController::Base
  helper_method :current_user, :log_in

  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end

  # 現在ログイン中のユーザーを返す (いる場合)
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def set_genrelist
    @genres_list = ["音楽", "ゲーム", "おもしろ系", "キッズ", "いやし", "メイク", "料理", "勉強", "ライフハック", "すべて"]
  end

  def genre_check(genre)

  end

end
