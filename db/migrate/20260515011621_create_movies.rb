class CreateMovies < ActiveRecord::Migration[8.1]
  def change
    create_table :movies do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :small_description
      t.string :image_url
      t.date :release_date, null: false
      t.string :country_code, null: false
      t.string :original_language, null: false
      t.integer :duration_in_minutes, null: false

      t.timestamps
    end
  end
end
