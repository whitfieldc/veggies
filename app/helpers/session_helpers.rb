helpers do

  def current_user
    cookies[:user_id]
  end

  def login(user, password)
    if user.password == password
      cookies[:user_id] = user.id
      true
    else
      false
    end
  end

  def logout
    cookies[:user_id] = nil
  end

  def logged_in?
    !!current_user
  end

end
