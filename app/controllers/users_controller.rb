class UsersController < ApplicationController
  
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
      flash[:success] = "Welcome to the Sample App!"
      #this is the same as "redirect_to user_url(@user)"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                      :password_confirmation)
    end
  
end
