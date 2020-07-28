class RecipesController < ApplicationController

  def index
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @recipes = @genre.recipes.page(params[:page]).reverse_order
      @title = @genre.name
    elsif params[:type_id]
      @type = Type.find(params[:type_id])
      @recipes = @type.recipes.page(params[:page]).reverse_order
      @title = @type.name
    elsif params[:tag_id]
      @tag = Tag.find(params[:tag_id])
      @recipes = @tag.recipes.page(params[:page]).reverse_order
      @title = @tag.name
    elsif params[:search]
      @recipes = Recipe.page(params[:page]).search(params[:search])
      if @recipes.blank?
        @title = "’ #{params[:search]} ’に一致する情報は見つかりませんでした。"
      else
        @title = "次の検索結果を表示しています ’ #{params[:search]} ’"
      end
    else
      @recipes = Recipe.page(params[:page]).reverse_order
      @title = "すべてのレシピ"
    end
  end

  def rank_index
    @recipes = Recipe.create_all_ranks.page(params[:page])
    @title = "ランキング"
  end

  def new_index
    @recipes = Recipe.page(params[:page]).order(created_at: :desc)
    @title = "新着レシピ"
  end

  def show
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new
    @comments = @recipe.comments.order(created_at: :desc)
    if user_signed_in?
      new_history = @recipe.browsing_histories.new
      new_history.user_id = current_user.id
      if current_user.browsing_histories.exists?(recipe_id: params[:id])
        old_history = current_user.browsing_histories.find_by(recipe_id: params[:id])
        old_history.destroy
      end
      new_history.save
      histories_stock_limit = 12
      histories = current_user.browsing_histories.all
      if histories.count > histories_stock_limit
        histories[0].destroy
      end
    end
  end

  def new
    @recipe = Recipe.new
  end

  # 確認画面
  def confirm
    @recipe = Recipe.find(params[:id])
    @genre = @recipe.genre
    @type = @recipe.type
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    tag_list = params[:recipe][:name].split(",")
    if @recipe.save
      @recipe.save_recipes(tag_list)
      # flash[:notice] = "レシピを投稿しました"
      redirect_to confirm_recipe_path(@recipe)
    else
      flash[:alert] = "入力内容を確認したください"
      render "new"
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @tag_list = @recipe.tags.pluck(:name).join(",")
    if @recipe.user != current_user
      redirect_to root_path, notice: "不正なアクセスです"
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    tag_list = params[:recipe][:name].split(",")
    if @recipe.update(recipe_params)
      @recipe.save_recipes(tag_list)
      redirect_to confirm_recipe_path(@recipe)
    else
      flash[:alert] = "入力内容を確認してください"
      render "edit"
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.user != current_user
      redirect_to root_path, notice: "不正なアクセスです"
    end
    @recipe.destroy
    redirect_to user_path(current_user.id)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :image, :body, :price, :quantity, :material, :make, :genre_id, :type_id, :user_id)
  end
end
