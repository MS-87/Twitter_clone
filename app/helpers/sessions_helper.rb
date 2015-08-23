module SessionsHelper
  
  # Logs in the given user.
  def log_in(user)
    #session is a rails function to add cookies to browsers
    session[:user_id] = user.id
  end
  
  #returns the current logged-in user (only if they exist)
  def current_user
    #the below is simislar to how x = x + 1, but with an OR operator
    # @foo = @foo || "test" (is the same as) @foo ||= "test"
    # will only write "test" if @foo is nil (nil = false)
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  #method for loggin out
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
