# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.uuid :uuid, default: 'gen_random_uuid()', unique: true
      t.string :state

      t.timestamps
    end
  end
end
