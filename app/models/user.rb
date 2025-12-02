class User < ApplicationRecord
  has_secure_password

  # [Associations]
  has_many :user_messages, -> { order(created_at: :desc) } # Establishes a one-to-many relationship with UserMessage, 
  # use @user.user_messages to get all messages for a user, ordered by creation time descending

  # [Validations]
  validates :name, {
    presence: true, 
    length: {maximum: 50}
  }
  validates :email, {
    presence: true, 
    uniqueness: true, 
    format: { with: URI::MailTo::EMAIL_REGEXP }
  }

end
