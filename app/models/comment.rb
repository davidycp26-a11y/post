class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :user_message

  validates :content, presence: true, length: { maximum: 200 }
  validates :user_id, presence: true
  validates :user_message_id, presence: true

  # Order comments chronologically (oldest first)
  default_scope { order(created_at: :asc) }
end
