class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    @recipes = @user.recipes
  end

  def edit
    if @user != current_user
      redirect_to root_path, notice: "不正なアクセスです"
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "情報を更新しました"
      redirect_to user_path(@user)
    else
      flash[:alert] = "入力情報を確認してください"
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image, :introduction)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
