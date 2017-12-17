class CreateAvailabilities < ActiveRecord::Migration[5.1]
  def change
    create_table :availabilities do |t|
      t.date :available_day
      t.references :room, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
