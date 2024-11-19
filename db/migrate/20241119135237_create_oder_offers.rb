# frozen_string_literal: true

class CreateOderOffers < ActiveRecord::Migration[8.0]
  def change
    create_table :oder_offers do |t|
      t.references :order, null: false, foreign_key: true, index: true
      t.references :offer, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
