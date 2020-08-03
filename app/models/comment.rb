class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  # バリテーション
  validates :comment, presence: true, length: { maximum: 100 }
  validates :score, numericality: {greater_than: -0.5, message: "ネガティブな表現が含まれるコメントは投稿できません"}
end
