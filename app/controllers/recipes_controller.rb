class RecipesController < ApplicationController

	def index
		@genres = Genre.all
		@types = Type.all
		@tags = Tag.all
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
		else
			# @recipes = Recipe.find(Like.group(:recipe_id).order('count(recipe_id) desc').pluck(:recipe_id)).page(params[:page])
			@recipes = Recipe.all.page(params[:page]).reverse_order
			@title = "全てのレシピ"
		end
	end

	def show
		@recipe = Recipe.find(params[:id])
		@comment = Comment.new
		@comments = @recipe.comments.order(created_at: :desc)
	end

	def new
		@recipe = Recipe.new
		@genres = Genre.all
		@types = Type.all
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
		@genres = Genre.all
		@types = Type.all
		@tag_list = @recipe.tags.pluck(:name).join(",")
	end

	def update
		@recipe = Recipe.find(params[:id])
		tag_list = params[:recipe][:name].split(",")
		if @recipe.update(recipe_params)
			@recipe.save_recipes(tag_list)
			flash[:notice] = "レシピを更新しました"
			redirect_to confirm_recipe_path(@recipe)
		else
			@genres = Genre.all
			@types = Type.all
			flash[:alert] = "入力内容を確認してください"
			render "edit"
		end
	end

	def destroy
		@recipe = Recipe.find(params[:id])
		@recipe.destroy
		redirect_to user_path(current_user.id)
	end

	private

	def recipe_params
		params.require(:recipe).permit(:title, :image, :body, :price, :quantity, :material, :make, :genre_id, :type_id, :user_id)
	end

end