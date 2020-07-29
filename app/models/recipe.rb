class Recipe < ApplicationRecord

  attachment :image

  belongs_to :genre
  belongs_to :type
  belongs_to :user
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :browsing_histories, dependent: :destroy
  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags
  has_many :notifications, dependent: :destroy

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


  # いいね順
  def self.create_all_ranks
    Recipe.joins(:likes).group(:recipe_id).order(Arel.sql('count(likes.user_id) desc'))
    # Recipe.joins(:likes).group(:recipe_id).order('count(user_id) desc') この記述だと警告分が出る
  end

  # 検索機能
  def self.search(search)
    if search
      Recipe.where([
        'title LIKE ? OR body LIKE ? OR body LIKE ? OR body LIKE ?',
         "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%"
      ])
    else
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
      self.tags.delete Tag.find_by(name: old_name)
    end

    # Create
    new_tags.each do |new_name|
      blog_tag = Tag.find_or_create_by(name: new_name)
      self.tags << blog_tag
    end
  end

  # 通知機能
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      recipe_id: id,
      visited_id: user_id,
      action: "like"
    )
    notification.save if notification.valid?
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(recipe_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      recipe_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
