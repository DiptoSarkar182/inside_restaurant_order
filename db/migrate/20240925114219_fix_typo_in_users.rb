class FixTypoInUsers < ActiveRecord::Migration[7.2]
  def change
    rename_column :users, :nationaity, :nationality
  end
end
