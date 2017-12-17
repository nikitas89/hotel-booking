class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.string :roomType
      t.text :description
      t.text :image
      t.integer :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
