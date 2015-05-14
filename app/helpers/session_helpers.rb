helpers do

  def current_user
    if session[session_key]
      User.where(session_key: session[:session_key]).first
    end
  end

  def login(user, password)
    if user.password == password
      session[:session_key] = user.get_key
      true
    else
      false
    end
  end

  def logout
    session[:session_key] = nil
  end

  def logged_in?
    !!current_user
  end

end
