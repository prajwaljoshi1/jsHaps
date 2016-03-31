class UsersController < ApplicationController

  before_action :require_same_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page], per_page:5)

  end


  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
        flash[:success] = "welcome to simple blog #{@user.username}."
        redirect_to user_path(@user)
    else
      flash[:danger] ="something went wrong"
      render'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Account was updated successfully"
      redirect_to articles_path
    else
      flash[:danger] ="something went wrong"
      render 'edit'
    end
  end

    def show
      @user = User.find(params[:id])
      @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      flash[:danger] = "User and all articles created by them has been deleted."
      redirect_to users_path

    end


  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = "You can only edit your account"
      redirect_to root_path
    end
  end

  def require_admin
    if logged_in? && !current_user.admin?
      flash[:danger] = "only admin users can perform this action"
      redirect_to root_path
    end
  end

end
