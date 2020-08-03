class LikesController < ApplicationController
  # お気に入り保存(非同期通信)
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @like = @recipe.likes.new(user_id: current_user.id)
    @like.save
    # いいねしたレシピのユーザーに通知
    @recipe.create_notification_by(current_user)
  end

  # お気に入り削除(非同期通信)
  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @like = current_user.likes.find_by(recipe_id: @recipe.id)
    @like.destroy
  end
end
