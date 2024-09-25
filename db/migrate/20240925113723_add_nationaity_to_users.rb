class AddNationaityToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :nationaity, :string
  end
end
