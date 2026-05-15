class CreateTheaters < ActiveRecord::Migration[8.1]
  def change
    create_table :theaters do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :country_code, null: false

      t.timestamps
    end
  end
end
