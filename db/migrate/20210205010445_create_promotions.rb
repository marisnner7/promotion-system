# frozen_string_literal: true

class CreatePromotions < ActiveRecord::Migration[6.1]
  def change
    create_table :promotions do |t|
      t.string :name
      t.string :description
      t.string :code
      t.decimal :discount_rate
      t.integer :coupon_quantity
      t.date :expiration_date
      t.integer :creator_id
      t.integer :approver_id, null: true
      t.datetime :approved_at

      t.timestamps
    end
  end
end
