class CreateRooms < ActiveRecord::Migration[8.1]
  def change
    create_table :rooms do |t|
      t.string :name, null: false
      t.references :theater, null: false, foreign_key: true
      t.references :room_model, null: false, foreign_key: true

      t.timestamps
    end
  end
end
