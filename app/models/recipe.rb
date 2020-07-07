class Recipe < ApplicationRecord

	attachment :image

	belongs_to :user
	belongs to :genre
	belongs_to :type
	has_many :comments
	has_many :likes
	has_many :recipe_tag

	# recipeにいいねしていたらtureを返す
	def liked_by?(user)
    likes.where(user_id: user.id).exists?
    end

end
