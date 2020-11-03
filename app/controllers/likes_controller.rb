class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    define_user
    @micropost = Micropost.find(params[:micropost_id])
    @like = @micropost.like(@user)
    @like_count = Like.where(micropost_id: params[:micropost_id]).count
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

  def destroy
    define_user
    @micropost = Like.find(params[:id]).micropost
    @micropost.unlike(@user)
    @like_count = Like.where(micropost_id: params[:micropost_id]).count
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
    end
  end

end