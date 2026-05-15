class CreateTickets < ActiveRecord::Migration[8.1]
  def change
    create_table :tickets do |t|
      t.references :showtime, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :seat, null: false, foreign_key: true
      t.string :status, null: false

      t.timestamps
    end
  end
end
