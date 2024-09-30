class RemoveAddressFromUser < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :address, :string
  end
end
