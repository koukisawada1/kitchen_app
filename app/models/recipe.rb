class Recipe < ApplicationRecord

	attachment :image

	belongs_to :genre
	belongs_to :type
	belongs_to :user
	has_many :comments
	has_many :likes
	has_many :recipe_tags

	# バリテーション
	validates :title, presence: true, length: { maximum: 30 }
	validates :body, presence: true, length: { maximum: 200 }
	validates :price, presence: true
	validates :quantity, presence: true
	validates :material, presence: true
	validates :make, presence: true
	validates :genre_id, presence: true
	validates :type_id, presence: true

	# recipeにいいねしていたらtureを返す
	def liked_by?(user)
    	likes.where(user_id: user.id).exists?
    end

end
