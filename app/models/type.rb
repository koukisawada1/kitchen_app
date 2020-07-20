class Type < ApplicationRecord

	attachment :image

	has_many :recipes

end
