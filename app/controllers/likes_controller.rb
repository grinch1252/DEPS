class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @user = current_user
    @like = @micropost.like(@user)
    @like_count = Like.where(micropost_id: params[:micropost_id]).count
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def destroy
    @micropost = Like.find(params[:id]).micropost
    @user = current_user
    @micropost.unlike(current_user)
    @like_count = Like.where(micropost_id: params[:micropost_id]).count
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end


end