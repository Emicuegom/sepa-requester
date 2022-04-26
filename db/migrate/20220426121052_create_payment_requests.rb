class CreatePaymentRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_requests do |t|
      t.string :full_name
      t.monetize :amount
      t.string :iban
      t.integer :status, default: 0
      t.references :user

      t.timestamps
    end
  end
end
