class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only:  :destroy


  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
   
    if @user.save
      
      UserMailer.account_activation(@user).deliver_now
      puts @user.email

      flash[:info] = "Please check your email to activate your account"
      redirect_to root_url
      #reset_session 
      #log_in @user
      #flash[:success] = "Welcome!"
      #handle a successful save
      #redirect_to @user
    else
      if @user.errors.any?
        @user.errors.messages.each do |msg|
          puts msg
        end
      end
      render 'new', status: :unprocessable_entity
   end
  end

  def edit
    @user = User.find(params[:id])
  end  

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      #handle a successful update
      flash[:success] = "Proile Updated"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
   end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url, status: :see_other
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow', status: :unprocessable_entity
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  #before filters

 

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url, status: :see_other) unless @user == current_user
  end

    # Confirms and admin
    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end
end
