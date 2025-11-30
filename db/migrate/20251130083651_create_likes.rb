class CreateLikes < ActiveRecord::Migration[8.1]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :user_message_id

      t.timestamps
    end
  end
end
