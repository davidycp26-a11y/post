class CreateUserMessages < ActiveRecord::Migration[8.1]
  def change
    create_table :user_messages do |t|
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end
end
