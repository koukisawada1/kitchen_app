class Genre < ApplicationRecord
  attachment :image

  has_many :recipes
end
