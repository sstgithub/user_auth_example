class AddImageIdAndUserIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :image_id, :string
    add_column :items, :user_id, :string
  end
end
