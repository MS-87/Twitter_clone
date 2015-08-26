module SessionsHelper
  
  # Logs in the given user.
  def log_in(user)
    #session is a rails function to add cookies to browsers
    #the idea of a user being "logged in", is executed by setting the session[:user_id]
    #to the current user.id
    session[:user_id] = user.id
  end
  
  #remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end
    
  
 # Returns the user corresponding to the remember token cookie.
  def current_user
    #The if statement below is potentially confusing
    #this is NOT a comparison ('=='), rather an assignement
    #just think of it without the 'if'(..). user_id = session[:user_id]
    #you assign the value of session[:user_id] to the new variable user_id
    #if the session ID existed, then the assignment is true, if it didn't, then it's false
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      #raise #Add this to raise an exception during tested, if it doesn't come up, this branch isn't tested
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  #Forgets a persistent session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
    
  
  #method for loggin out
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

# Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
