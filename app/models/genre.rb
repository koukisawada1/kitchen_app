class Genre < ApplicationRecord

	has_many :recipes, optional: true

end
