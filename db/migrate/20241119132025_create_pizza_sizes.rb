# frozen_string_literal: true

class CreatePizzaSizes < ActiveRecord::Migration[8.0]
  def change
    create_table :pizza_sizes do |t|
      t.string :name
      t.float :multiplier

      t.timestamps
    end
  end
end
