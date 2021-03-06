class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(:email => params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      if @user.activated?
        log_in @user
        params[:session][:remember_me] == "1" ? remember(@user) : forget(@user)
        redirect_to @user
      else
        flash[:danger] = "Please check email and activate your account."
        redirect_to root_url
      end
    else
      flash.now[:danger] = "Invalid combination email-address/password"
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
