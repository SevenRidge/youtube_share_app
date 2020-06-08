class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :destroy]

  def index
    if params[:post_genre]
      @posts = Post.where(genre: params[:post_genre]).order(created_at: :desc).paginate(page: params[:page], per_page: 9)
      @posts_num = @posts.count
    end
    if params[:post_genre]  == "すべて"
      @posts = Post.all.order(created_at: :desc).paginate(page: params[:page], per_page: 15)
      @posts_num = @posts.count
    end
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def update
    @post.update!(post_params)
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

  def destroy
    if @post.destroy
      redirect_to current_user, notice: "削除に成功しました"
    else
      redirect_to current_user, alert: "削除できませんでした"
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
