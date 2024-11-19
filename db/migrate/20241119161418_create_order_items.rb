# frozen_string_literal: true

class CreateOrderItems < ActiveRecord::Migration[8.0]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true, index: true
      t.references :pizza, null: false, foreign_key: true, index: true
      t.references :pizza_size, null: false, foreign_key: true, index: true
      t.text :add, array: true
      t.text :remove, array: true

      t.timestamps
    end
  end
end
