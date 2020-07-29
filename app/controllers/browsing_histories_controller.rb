class BrowsingHistoriesController < ApplicationController
  # 閲覧履歴一覧
  def index
    @recipes = current_user.browsing_historie_recipes
  end
end
