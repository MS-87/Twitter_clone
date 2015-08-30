class UsersController < ApplicationController
  
  #This says -- "run the method logged_in_users before running edit or update
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  def index
    #this won't be used anymore because of paginate:
    #@users = User.all
    #from paginate:
    @users = User.paginate(page: params[:page])
    #page: params[:page] comes from the modified route we see in the url
    #/users?page=1
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    #we need this because the <form> tag in our view needs access to a User
    #object 
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
      ###old code below
      ##log_in is defined in sessions_helper.rb
      #log_in @user
      #flash[:success] = "Welcome to the Sample App!"
      ##this is the same as "redirect_to user_url(@user)"
      #redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    #Don't need it now since it's defined in our before method
    #@user = User.find(params[:id])
  end
  
  def update
    #Don't need it now since it's defined in our before method
    #@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                      :password_confirmation)
    end
    
    def logged_in_user
      unless logged_in?
        store_location #defined in our helper, check it out.
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    # Confirms the correct user.
    #Here we define the @user variable, so we don't need it in edit anymore
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  
end
