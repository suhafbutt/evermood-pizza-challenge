# frozen_string_literal: true

class CreateOrderOffers < ActiveRecord::Migration[8.0]
  def change
    create_table :order_offers do |t|
      t.references :order, null: false, foreign_key: true, index: true
      t.references :offer, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
