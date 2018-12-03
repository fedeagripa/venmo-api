class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.integer :amount, null: false, default: 0
      t.text :description
      t.references :user
      t.references :receiver
      t.timestamps
    end
  end
end
