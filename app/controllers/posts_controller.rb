class PostsController < ApplicationController

  def index
    @posts =Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to root_path, success: "投稿できました"
    else
      render :new, danger: "投稿失敗しました"
    end
  end

  private
    def find_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:comment, :youtube_url, :genre)
    end

end
