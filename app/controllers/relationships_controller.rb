class RelationshipsController < ApplicationController
  before_action :find_user, only: [:create, :destroy]
  after_action :follow_or_following

  def create
    following = current_user.follow(@user)
  end

  def destroy
    following = current_user.unfollow(@user)
  end

  def find_user
    @user = User.find(params[:relationship][:follow_id])
  end

  def follow_or_following
    respond_to do |format|
      format.html {redirect_back(fallback_location: root_url)}
      format.js
    end
  end
end
