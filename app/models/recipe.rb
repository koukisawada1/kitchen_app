class Recipe < ApplicationRecord

	attachment :image

	belongs_to :genre
	belongs_to :type
	belongs_to :user
	has_many :comments
	has_many :likes
	has_many :recipe_tags


	# recipeにいいねしていたらtureを返す
	def liked_by?(user)
    likes.where(user_id: user.id).exists?
    end

end
