class Recipe < ApplicationRecord

	attachment :image

	belongs_to :user
	has_many :comments
	has_many :likes
	has_many :recipe_tag

	accepts_nested_attributes_for :genres
    accepts_nested_attributes_for :types

	# recipeにいいねしていたらtureを返す
	def liked_by?(user)
    likes.where(user_id: user.id).exists?
    end

end
