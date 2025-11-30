class Like < ApplicationRecord
  validates :user_id, presence: true, uniqueness: { scope: :user_message_id }
  validates :user_message_id, presence: true
end
