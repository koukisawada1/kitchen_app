class CommentsController < ApplicationController

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
		if @comment.user_id != current_user.id
			flash[:alert] = "不正なアクセスです"
			redirect_to root_path
		end
		@comment.destroy
		redirect_to recipe_path(@recipe)
	end

private
	def comment_params
		params.require(:comment).permit(:comment)
	end
end
