class Recipe < ApplicationRecord

	attachment :image

	belongs_to :genre
	belongs_to :type
	belongs_to :user
	has_many :comments
	has_many :likes
	has_many :recipe_tags, dependent: :destroy
	has_many :tags, through: :recipe_tags

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

    # 検索機能
    def self.search(search)
      if search
        Recipe.where(['title LIKE ? OR body LIKE ? OR body LIKE ? OR body LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"])
      else
      	flash[:alert] = "1文字以上入力してください"
        Recipe.all
      end
    end

    # タグ追加機能
    def save_recipes(tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    # Destroy
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end

    # Create
    new_tags.each do |new_name|
      blog_tag = Tag.find_or_create_by(name:new_name)
      self.tags << blog_tag
    end
  end
end
