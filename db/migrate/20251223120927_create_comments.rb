class CreateComments < ActiveRecord::Migration[8.1]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.references :user, null: false, foreign_key: true
      t.references :user_message, null: false, foreign_key: true

      t.timestamps
    end

    add_index :comments, [:user_message_id, :created_at]
  end
end
