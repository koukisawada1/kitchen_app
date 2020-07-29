class RecipesController < ApplicationController
  def index
    # 指定したジャンルのレシピ一覧
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @recipes = @genre.recipes.page(params[:page]).reverse_order
      @title = @genre.name
    # 指定した種別のレシピ一覧
    elsif params[:type_id]
      @type = Type.find(params[:type_id])
      @recipes = @type.recipes.page(params[:page]).reverse_order
      @title = @type.name
    elsif params[:tag_id]
      # 指定したタグのレシピ一覧
      @tag = Tag.find(params[:tag_id])
      @recipes = @tag.recipes.page(params[:page]).reverse_order
      @title = @tag.name
    # 検索機能
    elsif params[:search]
      @recipes = Recipe.page(params[:page]).search(params[:search])
      if @recipes.blank?
        # 検索がヒットしなかったときの処理
        @title = "’ #{params[:search]} ’に一致する情報は見つかりませんでした。"
      else
        # 検索がヒットしたときの処理
        @title = "次の検索結果を表示しています ’ #{params[:search]} ’"
      end
    else
      # idが送られてこなかった場合はレシピを全件取得
      @recipes = Recipe.page(params[:page]).reverse_order
      @title = "すべてのレシピ"
    end
  end

  # いいね数に応じたレシピのランキング
  def rank_index
    @recipes = Recipe.create_all_ranks.page(params[:page])
    @title = "ランキング"
  end

  # レシピ新着順
  def new_index
    @recipes = Recipe.page(params[:page]).order(created_at: :desc)
    @title = "新着レシピ"
  end

  # レシピ詳細ページ
  def show
    @recipe = Recipe.find(params[:id])
    @comment = Comment.new
    # コメントを新しい順に表示
    @comments = @recipe.comments.order(created_at: :desc)
    # ユーザーがログインしていた場合閲覧履歴として保存する
    if user_signed_in?
      new_history = @recipe.browsing_histories.new
      new_history.user_id = current_user.id
      # 重複しているレシピがある場合、古い方をを削除する
      if current_user.browsing_histories.exists?(recipe_id: params[:id])
        old_history = current_user.browsing_histories.find_by(recipe_id: params[:id])
        old_history.destroy
      end
      new_history.save
      # 閲覧履歴は12件まで保存する
      histories_stock_limit = 12
      histories = current_user.browsing_histories.all
      # 12件を超えた場合は古いものから削除
      if histories.count > histories_stock_limit
        histories[0].destroy
      end
    end
  end

  # レシピ投稿ページ
  def new
    @recipe = Recipe.new
  end

  # 確認画面
  def confirm
    @recipe = Recipe.find(params[:id])
    @genre = @recipe.genre
    @type = @recipe.type
  end

  　 # レシピの保存
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    # 入力されたタグをコンマで区切る
    tag_list = params[:recipe][:name].split(",")
    if @recipe.save
      @recipe.save_recipes(tag_list)
      redirect_to confirm_recipe_path(@recipe)
    else
      flash[:alert] = "入力内容を確認したください"
      render "new"
    end
  end

  # レシピ編集ページ
  def edit
    @recipe = Recipe.find(params[:id])
    # タグをコンマで区切る
    @tag_list = @recipe.tags.pluck(:name).join(",")
    if @recipe.user != current_user
      redirect_to root_path, notice: "不正なアクセスです"
    end
  end

  # レシピ編集情報更新
  def update
    @recipe = Recipe.find(params[:id])
    # 入力されたタグをコンマで区切る
    tag_list = params[:recipe][:name].split(",")
    if @recipe.update(recipe_params)
      @recipe.save_recipes(tag_list)
      redirect_to confirm_recipe_path(@recipe)
    else
      flash[:alert] = "入力内容を確認してください"
      render "edit"
    end
  end

  # レシピ削除
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
