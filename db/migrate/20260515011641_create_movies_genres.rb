class CreateMoviesGenres < ActiveRecord::Migration[8.1]
  def change
    create_table :movies_genres do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true
      t.boolean :main_genre, default: false

      t.timestamps
    end

    add_index :movies_genres, [ :movie_id, :genre_id ], unique: true
  end
end
