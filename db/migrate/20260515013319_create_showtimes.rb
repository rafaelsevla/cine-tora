class CreateShowtimes < ActiveRecord::Migration[8.1]
  def change
    create_table :showtimes do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.datetime :start_at, null: false
      t.string :language, null: false
      t.string :subtitle
      t.decimal :full_price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
