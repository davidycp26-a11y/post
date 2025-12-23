class UserMessage < ApplicationRecord
  # [Associations]
  belongs_to :user # Msg must have a user association, can use @user_message.user to get the user who posted the message
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  # [Validations]
  validates :content, {
    presence: true, 
    length: {maximum: 300}
  }
end
