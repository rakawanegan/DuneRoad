class CreateTokens < ActiveRecord::Migration[7.0]
  def change
    create_table :tokens do |t|
      t.string :title
      t.binary :image
      t.float :price
      t.integer :token_id
      t.integer :holder
      t.string :pre_holder
      t.string :tag
      t.time :timestamp
      t.text :detail

      t.timestamps
    end
  end
end
