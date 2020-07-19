class LikesController < ApplicationController
	before_action :header_action

	def create
		@recipe = Recipe.find(params[:recipe_id])
		@like = @recipe.likes.new(user_id: current_user.id)
		@like.save
	end

	def destroy
		@recipe = Recipe.find(params[:recipe_id])
		@like = current_user.likes.find_by(recipe_id: @recipe.id)
		@like.destroy
	end

private
	def header_action
		@genres = Genre.all
		@types = Type.all
		@tags = Tag.all
	end
end
