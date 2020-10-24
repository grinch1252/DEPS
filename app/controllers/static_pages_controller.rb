class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @user = current_user
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.page(params[:page]).per(8)
    end
  end

  def about
  end

end
