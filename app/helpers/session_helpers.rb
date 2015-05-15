helpers do

  def access_token
    request.env['HTTP_KEY']
  end

  def current_user
    @current_user ||= User.where(session_key: access_token).first
  end

  def authorized?
    !current_user.nil?
  end

  def ensure_authorized!
    return if authorized?
    content_type :json
    halt!(401, {error:'unauthorized'}.to_json)
  end

  # def login(user, password)
  #   if user.password_hash == password
  #     user.get_key
  #   else
  #     false
  #   end
  # end

  # def logout
  #   session[:session_key] = nil
  # end

  # def logged_in?
  #   !!current_user
  # end

end
