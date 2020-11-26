module TestHelper

  def is_logged_in?
    !session[:user_id].nil?
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def log_in_as(remember_me = 0)
    post login_path, :params => { :session => { :email => user.email,
                                                :password => user.password,
                                                :remember_me => remember_me } }
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

end