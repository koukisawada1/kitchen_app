class BrowsingHistoriesController < ApplicationController

	def index
		@recipes = current_user.browsing_historie_recipes
	end

end
