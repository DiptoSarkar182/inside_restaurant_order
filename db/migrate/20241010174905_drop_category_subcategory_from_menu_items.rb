class DropCategorySubcategoryFromMenuItems < ActiveRecord::Migration[7.2]
  def change
    remove_column :menu_items, :category, :string
    remove_column :menu_items, :subcategory, :string
  end
end
