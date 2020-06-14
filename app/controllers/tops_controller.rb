class TopsController < ApplicationController

  def index
    @genres_list = ["音楽", "アニメ", "ゲーム", "お笑い", "キッズ", "いやし", "美容", "料理", "勉強", "趣味", "ビジネス", "ニュース", "すべて"]
  end

end
