class RelationshipsController < ApplicationController
	before_action :header_action

	def create
		current_user.follow(params[:user_id])
		redirect_back(fallback_location: root_path)
	end

	def destroy
		current_user.unfollow(params[:user_id])
		redirect_back(fallback_location: root_path)
	end

private
	def header_action
		@genres = Genre.all
		@types = Type.all
		@tags = Tag.all
	end


end
