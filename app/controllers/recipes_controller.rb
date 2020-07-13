class RecipesController < ApplicationController

	def index
		@genres = Genre.all
		@types = Type.all
		@tags = Tag.all
		if params[:genre_id]
			@genre = Genre.find(params[:genre_id])
			@recipes = @genre.recipes
			@title = @genre.name
		elsif params[:type_id]
			@type = Type.find(params[:type_id])
			@recipes = @type.recipes
			@title = @type.name
		else
			@recipes = Recipe.all
			@title = "全てのレシピ"
		end
	end

	def show
		@recipe = Recipe.find(params[:id])
		@comment = Comment.new
		@comments = @recipe.comments
	end

	def new
		recipe = Recipe.new
	end

# 確認画面
	def confirm
	end

	def create
		recipe = Recipe.new(recipe_params)
		if recipe.save
			flash[:notice] = "レシピを投稿しました"
			redirect_to recipe_path(recipe.id)
		else
			flash[:alert] = "入力内容を確認したください"
			render "new"
		end
	end

	def edit
		@recipe = Recipe.find(params[:id])
	end

	def update
		@recipe = Recipe.find(params[:id])
		if @recipe.update(recipe_params)
			flash[:notice] = "レシピを更新しました"
			redirect_to recipe_path(@recipe.id)
		else
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
		params.require(:recipe).permit(:title, :image, :body, :price, :quantity, :material, :make)
	end

end