class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.string :code
      t.integer :status
      t.string :order
      t.references :promotion, null: false, foreign_key: true

      t.timestamps
    end
  end
end
