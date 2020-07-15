class HomesController < ApplicationController

	def top
		@genres = Genre.all
		@types = Type.all
		@like_recipes = Recipe.find(Like.group(:recipe_id).order('count(recipe_id) desc').limit(2).pluck(:recipe_id))
		@recipes = Recipe.all.order(created_at: :desc).limit(2) #=>新しい順の投稿2件
	end

	def about
	end

end
