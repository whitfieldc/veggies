helpers do

  def current_user
    if session[session_key]
      User.where(session_key: session[:session_key]).first
    end
  end

  def login(user, password)
    if user.password_hash == password
      user.get_key
    else
      false
    end
  end

  # def logout
  #   session[:session_key] = nil
  # end

  # def logged_in?
  #   !!current_user
  # end

end
