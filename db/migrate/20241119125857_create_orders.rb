# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.text :uuid, null: false
      t.string :state

      t.timestamps
    end
  end
end
