class StatisticsController < ApplicationController
  def index
    @posts = Post.order(created_at: :desc)
    @all_ranks = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end
end
