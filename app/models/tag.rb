class Tag < ApplicationRecord

	has_many :recipe_tags
	# has_many :tag_recipes, through: :tag_recipes, source: :tag

end
