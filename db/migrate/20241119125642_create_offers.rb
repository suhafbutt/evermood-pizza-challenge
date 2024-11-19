# frozen_string_literal: true

class CreateOffers < ActiveRecord::Migration[8.0]
  def change
    create_table :offers do |t|
      t.string :code
      t.string :type
      t.integer :discount
      t.string :target
      t.string :target_size
      t.integer :from
      t.integer :to

      t.timestamps
    end
  end
end
