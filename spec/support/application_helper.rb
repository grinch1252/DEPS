module ApplicationHelpers

  def is_logged_in?
    !session[:user_id].nil?
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def log_in_as(user, remember_me = 0)
    get login_path
    post login_path, :params => { :session => { :email => user.email,
                                                :password => user.password,
                                                :remember_me => remember_me } }
  end

  def valid_edit
    patch user_path(user), :params => { :user => {  :name => "testuser",
                                                    :email => "test@valid.com",
                                                    :password => "foobar",
                                                    :password_confirmation => "foobar" } }
  end

  def invalid_edit
    patch user_path(user), :params => { :user => {  :name => "",
                                                    :email => "foo@invalid",
                                                    :password => "foo",
                                                    :password_confirmation => "bar" } }
  end

end