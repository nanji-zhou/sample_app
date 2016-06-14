module SessionsHelper
 def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user  #set current_user
  end
  
  #set current_user 
  def current_user=(user)
    @current_user = user
  end
  #get current_user
  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end
  
  def signed_in?
    !current_user.nil?
  end
end
