class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @user = current_user
      @micropost = Micropost.new
      @feed_items = current_user.feed.page(params[:page]).per(7)
      @like_count = Like.where(micropost_id: params[:micropost_id]).count
    end
  end

  def about
  end

end
