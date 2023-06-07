class AddColumnToToken < ActiveRecord::Migration[7.0]
  def change
	  add_column :tokens, :admin, :boolean, default: false
	  change_column_default :tokens, :holder, from: nil, to: 1
  end
end
