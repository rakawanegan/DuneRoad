class ChangeColumnDefaultToUsers < ActiveRecord::Migration[7.0]
  def change
  	change_column_default :users, :assets, from: nil, to: 0
  end
end
