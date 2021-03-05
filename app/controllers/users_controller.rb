class UsersController < ApplicationController
  
  before_action :require_user_logged_in, only: [:index, :show, :edit, :likes, :followings]
  
  def index
    @users = User.order(id: :desc)
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:notice] = "ユーザーの登録に成功しました。"
      redirect_to @user
    else
      render :new
    end
    
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update(user_profile_params)
      flash[:notice] = "プロフィールを編集しました。"
      redirect_to @user
    else
      render :edit
    end
    
  end
  
  def likes
    @user = User.find(params[:id])
  end
  
  def followings
    @user = User.find(params[:id])
  end
  
  private
  
  #Strong Parameter
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def user_profile_params
    params.require(:user).permit(:name, :genre, :place, :introduction, :image)
  end

end
