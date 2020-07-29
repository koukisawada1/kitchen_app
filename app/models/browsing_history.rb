class BrowsingHistory < ApplicationRecord
  # 閲覧履歴を新しい順から取得
  default_scope -> { order(created_at: :desc) }

  belongs_to :user
  belongs_to :recipe
end
