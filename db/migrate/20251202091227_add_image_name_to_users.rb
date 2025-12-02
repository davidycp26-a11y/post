class AddImageNameToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :image_name, :string
  end
end
