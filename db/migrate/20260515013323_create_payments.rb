class CreatePayments < ActiveRecord::Migration[8.1]
  def change
    create_table :payments do |t|
      t.references :ticket, null: false, foreign_key: true
      t.decimal :amount, null: false
      t.string :payment_method, null: false
      t.string :transaction_id, null: false
      t.string :status, null: false
      t.datetime :paid_at
      t.string :card_last_four
      t.text :gateway_response

      t.timestamps
    end
  end
end
