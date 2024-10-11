class AddCategoryIdToMenuItems < ActiveRecord::Migration[7.2]
  def change
    add_reference :menu_items, :category, null: false, foreign_key: true
  end
end
