class HomesController < ApplicationController
  def top
    @like_recipes = Recipe.find(Like.group(:recipe_id).order('count(recipe_id) desc').limit(3).pluck(:recipe_id))
    @recipes = Recipe.all.order(created_at: :desc).limit(3) #=>新しい順の投稿2件
  end

  def about
  end

  def new_guest
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
      user.introduction = "よろしくお願いします！"
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
