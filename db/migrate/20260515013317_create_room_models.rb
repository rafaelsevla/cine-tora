class CreateRoomModels < ActiveRecord::Migration[8.1]
  def change
    create_table :room_models do |t|
      t.string :name, null: false
      t.integer :rows_count, null: false
      t.integer :columns_count, null: false

      t.timestamps
    end
  end
end
