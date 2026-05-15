class CreateSeats < ActiveRecord::Migration[8.1]
  def change
    create_table :seats do |t|
      t.references :room, null: false, foreign_key: true
      t.string :row, null: false
      t.integer :column, null: false
      t.string :number, null: false

      t.timestamps
    end
  end
end
