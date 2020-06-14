class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :destroy]

  def index
    if params[:post_genre]  == "すべて"
      @posts = Post.all.order(created_at: :desc)
    else
      @posts = Post.where(genre: params[:post_genre]).order(created_at: :desc)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    check_youtubeurl @post.youtube_url
    if @post.save
      redirect_to @post.user, notice: "投稿できました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    @post.update!(post_params)
    redirect_to post.user, notice: "編集できました"
  end

  def destroy
    if @post.destroy
      redirect_to current_user, notice: "削除に成功しました"
    else
      redirect_to current_user, alert: "削除できませんでした"
    end
  end

  def find_post
    @post = Post.find(params[:id])
  end

  private
    def post_params
      params.require(:post).permit(:comment, :youtube_url, :genre)
    end
end
