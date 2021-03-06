class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :new_user, only: %i[new create]
  around_action :save_user, only: %i[create update]
  before_action :require_user, only: %i[edit update]
  before_action :require_same_user, only: %i[edit update destroy]


  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def new; end

  def edit; end

  def update; end

  def create; end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and all associated articles successfully deleted"
    redirect_to articles_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def new_user
    @user = User.new
  end

  def save_user
    return_to_page = params[:action] == 'create' ? 'new' : 'edit'

    if @user.update(user_params)
      create_flash = "Welcome to the Alpha Blog #{@user.username}, you have successfully signed up!"
      update_flash = "Your account information was successfully updated"
      flash_notice = params[:action] == 'create' ? create_flash : update_flash
      session[:user_id] = @user.id if params[:action] == 'create'
      flash[:notice] = flash_notice
      redirect_to user_path(@user)
    else
      render return_to_page
    end
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit your own profile"
      redirect_to @user
    end
  end
end