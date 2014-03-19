helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end

  def current_user=(id)
    session[:user_id] = id
    current_user
  end

 
  def clear_user
    session.delete(:user_id)
  end
  
  def logged_in
    !current_user.nil?
  end
end