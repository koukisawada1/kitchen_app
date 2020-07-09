class Type < ApplicationRecord

	has_many :recipes, optional: true

end
