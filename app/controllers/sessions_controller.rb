class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      # log_in is a function we define in the sessions_helper.rb module
      # It creates a temp cookie for the user
      log_in user
      redirect_to user
    else
      # Create an error message
      #Since flash lives for 1 request, and render is NOT a new request
      #... then the flash would still be there if we cahnged pages.
      #To avoid this, we use flash.now
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to root_url
  end
  
end
