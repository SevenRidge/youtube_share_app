class PostsController < ApplicationController

  def index
    @posts = Post.all.order(created_at: :desc).paginate(page: params[:page], per_page: 9)
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update!(post_params)
    redirect_to post.user, notice: "編集できました"
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to @post.user, notice: "投稿できました"
    else
      render :new
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
