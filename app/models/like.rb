class Like < ApplicationRecord
  # [Associations]
  belongs_to :user
  belongs_to :user_message

  # [Validations]
  validates :user_id, presence: true, uniqueness: { scope: :user_message_id }
  validates :user_message_id, presence: true
end
