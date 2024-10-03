class ChangeDescriptionToAllowNullInMenuItems < ActiveRecord::Migration[7.2]
  def change
    change_column_null :menu_items, :description, true
  end
end
