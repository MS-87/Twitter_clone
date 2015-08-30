class PasswordResetsController < ApplicationController
  
  #We need to get the user before running the :edit and :update actions
  #this is not common but for this situation it's necessary
  #the user email will be provided from the URL params
  #ie params[:email] from clicking the link
  #HOWEVEr we reference the password as params[:user][:password] since that is NOT
  #provided int he URL
  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  
  
  def new
  end
  
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if password_blank?
      flash.now[:danger] = "Password can't be blank"
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "Password has been reset."
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
    
    # Returns true if password is blank.
    def password_blank?
      params[:user][:password].blank?
    end
  
    def get_user
      #here the params[:email] is pereserved in the hidden form tag in the edit view.
      @user = User.find_by(email: params[:email])
    end
    
    #confirm valid user
    def valid_user
      unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end
    
    # Checks expiration of reset token.
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end
end

