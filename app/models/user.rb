class User < ApplicationRecord
  has_secure_password

  # [Associations]
  has_many :user_messages, -> { order(created_at: :desc) } # Establishes a one-to-many relationship with UserMessage,
  # use @user.user_messages to get all messages for a user, ordered by creation time descending
  has_many :likes, dependent: :destroy
  has_many :liked_messages, through: :likes, source: :user_message
  has_many :comments, dependent: :destroy
  
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
  
  # [Active Storage for Avatar Image]
  has_one_attached :avatar # Uncomment this line if using Active Storage for avatar uploads
  # app/models/user.rb

  def self.avatar_options
    Dir.glob(Rails.root.join("public", "avatars", "*.png"))
      .map { |path| File.basename(path) }
      .sort
  end

  def avatar_url
    if image_name.present?
      "/avatars/#{image_name}"   # public/avatars/xxx.png
    else
      "/avatars/default.png"     # public/avatars/default.png
    end
  end

end
