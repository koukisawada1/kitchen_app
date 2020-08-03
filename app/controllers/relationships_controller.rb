class RelationshipsController < ApplicationController
  # フォローする
  def create
    @user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
    # フォローした人へ通知
    @user.create_notification_follow!(current_user)
    redirect_back(fallback_location: root_path)
  end

  # フォローを外す
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end
end
