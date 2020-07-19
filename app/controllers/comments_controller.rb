class CommentsController < ApplicationController
	before_action :header_action

	def create
		@recipe = Recipe.find(params[:recipe_id])
		@comment = Comment.new(comment_params)
		@comment.recipe_id = @recipe.id
		@comment.user_id = current_user.id
		if @comment.save
			flash[:notice] = "コメントを投稿しました"
			redirect_to recipe_path(@recipe)
		else
			@comments = @recipe.comments
			flash[:alert] = "入力内容を確認してください"
			render "recipes/show"
		end
	end

	def destroy
		@recipe = Recipe.find(params[:recipe_id])
		@comment = Comment.find_by(id: params[:id], recipe_id: @recipe.id)
		@comments = @recipe.comments.order(created_at: :desc)
		if @comment.user_id != current_user.id
			flash[:alert] = "不正なアクセスです"
			redirect_to root_path
		end
		@comment.destroy
		render :index
	end

private
	def comment_params
		params.require(:comment).permit(:comment)
	end

	def header_action
		@genres = Genre.all
		@types = Type.all
		@tags = Tag.all
	end
end
