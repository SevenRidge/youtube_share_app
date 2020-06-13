class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Tube!"
      redirect_to @user
    else

      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).paginate(page: params[:page], per_page: 6)
  end

  def followings
    @user =User.find(params[:id])
    @users =@user.followings.page(params[:page]).per(5)
    render 'show_followings'
  end

  def followers
    @user =User.find(params[:id])
    @users =@user.followers.page(params[:page]).per(5)
    render 'show_followers'
  end

  def following
    @user =User.find(params[:id])
    @users =@user.followings
    render 'show_followings'
  end

  def followers
    @user =User.find(params[:id])
    @users =@user.followers
    render 'show_followers'
  end

  private

    def user_params
      params.require(:user).permit(:image, :name, :sex, :age, :email, :password, :password_confirmation)
    end
end
