class LikesController < ApplicationController

	def index
		@likes = current_user.likes
	end

	def create
	end

	def destroy
	end

end
